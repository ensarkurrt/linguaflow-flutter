import 'dart:convert';

import 'package:flutter/services.dart';

const String linguaflowApiOrigin = 'https://api.linguaflow.dev';

enum MissingTranslationBehavior { fallback, key, empty, throwException }

class LinguaFlowConfig {
  const LinguaFlowConfig({
    required this.branchKey,
    this.cacheTtl = const Duration(minutes: 5),
    this.bundledAssetPath = 'assets/linguaflow',
    this.offlineEnabled = true,
    this.missingTranslationBehavior = MissingTranslationBehavior.fallback,
    this.generatorOutput = 'lib/generated/linguaflow_keys.dart',
    this.overlay,
    this.missingKeyTelemetryEnabled = false,
    this.appVersion = '',
  });

  factory LinguaFlowConfig.fromJson(Map<String, dynamic> json) {
    final offline = _optionalObject(json, 'offline');
    final missing =
        _optionalString(offline, 'missingTranslation') ?? 'fallback';
    final branchKey = json['branchKey'];
    final overlay = json['overlay'];
    final cacheTtlSeconds = _optionalInt(json, 'cacheTtlSeconds') ?? 300;
    final telemetry = _optionalObject(json, 'telemetry');
    if (branchKey is! String ||
        !RegExp(r'^br_live_[A-Za-z0-9_-]+$').hasMatch(branchKey)) {
      throw const FormatException(
          'branchKey must be a LinguaFlow public delivery key.');
    }
    if (cacheTtlSeconds < 0) {
      throw const FormatException('cacheTtlSeconds cannot be negative.');
    }
    if (overlay != null &&
        (overlay is! String ||
            !RegExp(r'^[a-z0-9][a-z0-9-]{1,47}$').hasMatch(overlay))) {
      throw const FormatException('overlay must be a valid stable slug.');
    }
    return LinguaFlowConfig(
      branchKey: branchKey,
      cacheTtl: Duration(seconds: cacheTtlSeconds),
      bundledAssetPath:
          _optionalString(json, 'bundledPath') ?? 'assets/linguaflow',
      offlineEnabled: _optionalBool(offline, 'enabled') ?? true,
      missingTranslationBehavior: switch (missing) {
        'key' => MissingTranslationBehavior.key,
        'empty' => MissingTranslationBehavior.empty,
        'throw' => MissingTranslationBehavior.throwException,
        _ => MissingTranslationBehavior.fallback,
      },
      generatorOutput: _optionalString(json, 'output') ??
          'lib/generated/linguaflow_keys.dart',
      overlay: overlay as String?,
      missingKeyTelemetryEnabled:
          _optionalBool(telemetry, 'missingKeys') ?? false,
      appVersion: _optionalString(telemetry, 'appVersion') ?? '',
    );
  }

  static Future<LinguaFlowConfig> load({
    AssetBundle? assetBundle,
    String path = '.linguaconfig',
  }) async {
    final raw = await (assetBundle ?? rootBundle).loadString(path);
    final decoded = jsonDecode(raw);
    if (decoded is! Map) {
      throw const FormatException('.linguaconfig must contain a JSON object.');
    }
    return LinguaFlowConfig.fromJson(decoded.cast<String, dynamic>());
  }

  final String branchKey;
  final Duration cacheTtl;
  final String bundledAssetPath;
  final bool offlineEnabled;
  final MissingTranslationBehavior missingTranslationBehavior;
  final String generatorOutput;
  final String? overlay;
  final bool missingKeyTelemetryEnabled;
  final String appVersion;

  void validate() {
    if (!RegExp(r'^br_live_[A-Za-z0-9_-]+$').hasMatch(branchKey)) {
      throw ArgumentError.value(
          branchKey, 'branchKey', 'Invalid public delivery key.');
    }
    if (cacheTtl.isNegative) {
      throw ArgumentError.value(
          cacheTtl, 'cacheTtl', 'TTL cannot be negative.');
    }
    if (overlay != null &&
        !RegExp(r'^[a-z0-9][a-z0-9-]{1,47}$').hasMatch(overlay!)) {
      throw ArgumentError.value(
          overlay, 'overlay', 'Invalid stable overlay slug.');
    }
    if (bundledAssetPath.startsWith('/') ||
        bundledAssetPath.contains('..') ||
        bundledAssetPath.contains('://')) {
      throw ArgumentError.value(
        bundledAssetPath,
        'bundledAssetPath',
        'Must be a package-relative asset directory.',
      );
    }
  }
}

enum LinguaFlowBundleSource { remote, downloaded, bundled }

Map<String, dynamic> _optionalObject(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value == null) return const {};
  if (value is! Map) throw FormatException('$key must be an object.');
  return value.cast<String, dynamic>();
}

String? _optionalString(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value == null) return null;
  if (value is! String) throw FormatException('$key must be a string.');
  return value;
}

int? _optionalInt(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value == null) return null;
  if (value is! int) throw FormatException('$key must be an integer.');
  return value;
}

bool? _optionalBool(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value == null) return null;
  if (value is! bool) throw FormatException('$key must be a boolean.');
  return value;
}
