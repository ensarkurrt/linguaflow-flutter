import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/message_format.dart';

import 'delivery_api.dart';
import 'device_integrity.dart';
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';
import 'localization_cache.dart';
import 'missing_key_reporter.dart';
import 'offline_locale_resolver.dart';

class LinguaFlowClient extends ChangeNotifier {
  LinguaFlowClient({
    required this.config,
    http.Client? httpClient,
    LocalizationCache? cache,
    AssetBundle? assetBundle,
    LinguaFlowDeviceIntegrityProvider? deviceIntegrityProvider,
  })  : _http = httpClient ?? http.Client(),
        _ownsHttpClient = httpClient == null,
        _cache = cache ?? LocalizationCache(),
        _assetBundle = assetBundle ?? rootBundle {
    _api = DeliveryApi(
      config: config,
      httpClient: _http,
      installationId: _loadInstallationId,
      integrityProvider: deviceIntegrityProvider,
    );
    _missingKeys = MissingKeyReporter(
      config: config,
      api: _api,
      manifest: () => _manifest,
    );
  }

  static Future<LinguaFlowClient> create({
    http.Client? httpClient,
    LocalizationCache? cache,
    AssetBundle? assetBundle,
    bool initialize = true,
    LinguaFlowDeviceIntegrityProvider? deviceIntegrityProvider,
  }) async {
    final config = await LinguaFlowConfig.load(assetBundle: assetBundle);
    final client = LinguaFlowClient(
      config: config,
      httpClient: httpClient,
      cache: cache,
      assetBundle: assetBundle,
      deviceIntegrityProvider: deviceIntegrityProvider,
    );
    if (initialize) await client.initialize();
    return client;
  }

  final LinguaFlowConfig config;
  final http.Client _http;
  final bool _ownsHttpClient;
  final LocalizationCache _cache;
  final AssetBundle _assetBundle;
  late final DeliveryApi _api;
  late final MissingKeyReporter _missingKeys;
  Map<String, dynamic>? _activeBundle;
  LocaleManifest? _manifest;
  DateTime? _lastCheckedAt;
  String? _selectedLocale;
  String? _installationId;
  LinguaFlowBundleSource? _bundleSource;
  bool _loading = false;

  String? get selectedLocale => _selectedLocale;
  String? get activeLocale {
    final manifest = _manifest;
    if (manifest == null) return null;
    return manifest.reason == LocaleResolutionReason.mapped
        ? manifest.requestedLocale
        : manifest.resolvedLocale;
  }

  String? get resolvedLocale => _manifest?.resolvedLocale;
  String? get fallbackLocale => _manifest?.fallbackLocale;
  List<String> get supportedLocales =>
      List.unmodifiable(_manifest?.supportedLocales ?? const []);
  LinguaFlowBundleSource? get bundleSource => _bundleSource;
  bool get isLoading => _loading;
  bool get isReady => _activeBundle != null;
  String get _bundleCachePrefix =>
      '${config.branchKey}:${config.overlay ?? 'base'}';
  bool isLocaleSupported(String locale) {
    final normalized = normalizeLocale(locale);
    return supportedLocales.any((item) =>
        normalizeLocale(item) == normalized ||
        normalizeLocale(item).split('-').first == normalized.split('-').first);
  }

  Future<void> initialize(
      {String? deviceLocale, bool forceRefresh = false}) async {
    _installationId ??= await _loadInstallationId();
    _selectedLocale ??=
        await _cache.readValue('${config.branchKey}:selected-locale');
    await _refresh(
      selectedLocale: _selectedLocale,
      deviceLocale:
          deviceLocale ?? PlatformDispatcher.instance.locale.toLanguageTag(),
      forceRefresh: forceRefresh,
    );
  }

  Future<void> selectLocale(String locale) async {
    final value = locale.trim();
    if (value.isEmpty) return clearLocalePreference();
    _selectedLocale = value;
    await _cache.writeValue('${config.branchKey}:selected-locale', value);
    await _refresh(selectedLocale: value, forceRefresh: true);
  }

  Future<void> clearLocalePreference() async {
    _selectedLocale = null;
    await _cache.removeValue('${config.branchKey}:selected-locale');
    await _refresh(
      deviceLocale: PlatformDispatcher.instance.locale.toLanguageTag(),
      forceRefresh: true,
    );
  }

  Future<void> refresh() => _refresh(
        selectedLocale: _selectedLocale,
        deviceLocale: PlatformDispatcher.instance.locale.toLanguageTag(),
        forceRefresh: true,
      );

  Future<void> load(String locale, {bool forceRefresh = false}) async {
    await _refresh(selectedLocale: locale, forceRefresh: forceRefresh);
  }

  Future<void> _refresh({
    String? selectedLocale,
    String? deviceLocale,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh &&
        _activeBundle != null &&
        _lastCheckedAt != null &&
        DateTime.now().difference(_lastCheckedAt!) <= config.cacheTtl) {
      return;
    }
    _loading = true;
    notifyListeners();
    try {
      final requestedLocale = selectedLocale ?? deviceLocale ?? 'en';
      final manifest = await _api.manifest(
        locale: requestedLocale,
        explicit: selectedLocale != null,
      );
      _lastCheckedAt = DateTime.now();
      _manifest = manifest;
      await _cache.writeValue(
          '$_bundleCachePrefix:manifest', jsonEncode(manifest.toJson()));
      if (selectedLocale != null &&
          manifest.reason == LocaleResolutionReason.fallback &&
          !isLocaleSupported(selectedLocale)) {
        _selectedLocale = null;
        await _cache.removeValue('${config.branchKey}:selected-locale');
      }
      final cacheKey = '$_bundleCachePrefix:${manifest.resolvedLocale}';
      final downloaded = await _cache.read(cacheKey, maxAge: null);
      if (downloaded?.releaseId == manifest.releaseId) {
        _activate(downloaded!.data, LinguaFlowBundleSource.downloaded);
        return;
      }
      final delivery = await _api.bundle(
        locale: manifest.resolvedLocale,
        etag: downloaded?.etag,
      );
      switch (delivery) {
        case BundleNotModified():
          if (downloaded == null) {
            throw LinguaFlowException(
                'Bundle returned 304 without a cached representation', null);
          }
          _activate(downloaded.data, LinguaFlowBundleSource.downloaded);
        case BundleContent(:final data, :final etag):
          await _cache.write(cacheKey, data,
              etag: etag, releaseId: manifest.releaseId);
          _activate(data, LinguaFlowBundleSource.remote);
      }
    } catch (error) {
      if (!config.offlineEnabled) rethrow;
      final offlineManifest = _manifest ??
          await _readCachedManifest() ??
          await _readBundledManifest();
      if (offlineManifest != null) {
        _manifest = offlineManifest;
        final resolution = resolveOfflineLocale(offlineManifest,
            selectedLocale: selectedLocale, deviceLocale: deviceLocale);
        final downloaded = await _cache.read(
            '$_bundleCachePrefix:${resolution.resolvedLocale}',
            maxAge: null);
        if (downloaded != null) {
          _manifest = offlineManifest.withResolution(resolution);
          await _clearRemovedSelection(selectedLocale, resolution.reason);
          _activate(downloaded.data, LinguaFlowBundleSource.downloaded);
          return;
        }
        final bundled = await _readBundled(resolution.resolvedLocale) ??
            (resolution.resolvedLocale == offlineManifest.fallbackLocale
                ? null
                : await _readBundled(offlineManifest.fallbackLocale));
        if (bundled != null) {
          _manifest = offlineManifest.withResolution((
            requestedLocale: resolution.requestedLocale,
            resolvedLocale: bundled.$1,
            reason: resolution.reason,
          ));
          await _clearRemovedSelection(selectedLocale, resolution.reason);
          _activate(bundled.$2, LinguaFlowBundleSource.bundled);
          return;
        }
      }
      final configuredAsset =
          await _readBundled(selectedLocale ?? deviceLocale);
      if (configuredAsset != null) {
        _manifest = LocaleManifest(
          version: 1,
          releaseId: 'bundled',
          sequence: 0,
          requestedLocale: configuredAsset.$1,
          resolvedLocale: configuredAsset.$1,
          supportedLocales: [configuredAsset.$1],
          translatedLocales: [configuredAsset.$1],
          fallbackLocale: configuredAsset.$1,
          localeMappings: const {},
          reason: LocaleResolutionReason.fallback,
          bundlePath: '',
          overlays: const [],
          overlay: null,
          missingKeyTelemetryEnabled: false,
          missingKeyTelemetryMaxBatchSize: 100,
          rolloutCandidateReleaseId: 'bundled',
          rolloutPercentage: 100,
          rolloutSelection: 'stable',
        );
        _activate(configuredAsset.$2, LinguaFlowBundleSource.bundled);
        return;
      }
      throw LinguaFlowException(
        'No remote, downloaded, or bundled localization is available',
        error is LinguaFlowException ? error.statusCode : null,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<String> _loadInstallationId() async {
    final key = '${config.branchKey}:installation-id';
    final existing = await _cache.readValue(key);
    if (existing != null && existing.isNotEmpty) return existing;
    final random = Random.secure();
    final created = List.generate(16, (_) => random.nextInt(256))
        .map((value) => value.toRadixString(16).padLeft(2, '0'))
        .join();
    await _cache.writeValue(key, created);
    return created;
  }

  Future<LocaleManifest?> _readCachedManifest() async {
    final raw = await _cache.readValue('$_bundleCachePrefix:manifest');
    return raw == null
        ? null
        : LocaleManifest.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<LocaleManifest?> _readBundledManifest() async {
    try {
      final raw = await _assetBundle
          .loadString('${config.bundledAssetPath}/manifest.json');
      return LocaleManifest.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<(String, Map<String, dynamic>)?> _readBundled(String? locale) async {
    if (locale == null || locale.isEmpty) return null;
    try {
      final raw = await _assetBundle
          .loadString('${config.bundledAssetPath}/$locale.json');
      final body = jsonDecode(raw) as Map<String, dynamic>;
      return (locale, body);
    } catch (_) {
      return null;
    }
  }

  Future<void> _clearRemovedSelection(
      String? selectedLocale, LocaleResolutionReason reason) async {
    if (selectedLocale == null || reason != LocaleResolutionReason.fallback) {
      return;
    }
    _selectedLocale = null;
    await _cache.removeValue('${config.branchKey}:selected-locale');
  }

  void _activate(Map<String, dynamic> data, LinguaFlowBundleSource source) {
    _activeBundle = data;
    _bundleSource = source;
    notifyListeners();
  }

  String? lookup(LfKey key,
      {Map<String, Object> arguments = const {},
      Map<String, dynamic>? bundle}) {
    dynamic value = bundle ?? _activeBundle;
    for (final segment in key.path.split('.')) {
      if (value is! Map<String, dynamic>) return null;
      value = value[segment];
    }
    if (value is! String) return null;
    try {
      return MessageFormat(value, locale: resolvedLocale ?? 'en')
          .format({...key.arguments, ...arguments});
    } on FormatException catch (error) {
      throw LinguaFlowException(
          'Invalid ICU MessageFormat for ${key.path}: ${error.message}', null);
    }
  }

  String resolve(LfKey key,
      {Map<String, Object> arguments = const {}, String fallback = ''}) {
    final value = lookup(key, arguments: arguments);
    if (value != null) return value;
    _missingKeys.record(key.path);
    return switch (config.missingTranslationBehavior) {
      MissingTranslationBehavior.fallback => fallback,
      MissingTranslationBehavior.key => key.path,
      MissingTranslationBehavior.empty => '',
      MissingTranslationBehavior.throwException =>
        throw LinguaFlowException('Missing translation: ${key.path}', null),
    };
  }

  Future<void> flushMissingKeys() => _missingKeys.flush();

  @override
  void dispose() {
    _missingKeys.dispose();
    if (_ownsHttpClient) _http.close();
    super.dispose();
  }
}
