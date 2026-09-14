import 'dart:convert';

import 'package:http/http.dart' as http;

import 'device_integrity.dart';
import 'generated/runtime_contract/api.dart' as contract;
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';
import 'safe_http_client.dart';

typedef TranslationBundle = Map<String, dynamic>;

const _maxManifestBytes = 256 * 1024;
const _maxBundleBytes = 5 * 1024 * 1024;
const _maxTelemetryResponseBytes = 256 * 1024;
const _maxBundleDepth = 32;
const _maxBundleValues = 100000;
const _unsafeObjectKeys = {'__proto__', 'prototype', 'constructor'};

sealed class BundleDelivery {
  const BundleDelivery();
}

class BundleNotModified extends BundleDelivery {
  const BundleNotModified();
}

class BundleContent extends BundleDelivery {
  const BundleContent(this.data, this.etag);

  final TranslationBundle data;
  final String? etag;
}

class BundlePayloadException extends LinguaFlowException {
  BundlePayloadException() : super('Invalid LinguaFlow API response', null);
}

class MissingKeysReport {
  const MissingKeysReport({
    required this.requestId,
    required this.locale,
    required this.appVersion,
    required this.telemetryToken,
    required this.keys,
  });

  final String requestId;
  final String locale;
  final String appVersion;
  final String telemetryToken;
  final List<String> keys;

  Map<String, Object> toJson() => {
        'requestId': requestId,
        'locale': locale,
        'appVersion': appVersion,
        'keys': keys,
      };
}

class DeliveryApi {
  DeliveryApi({
    required LinguaFlowConfig config,
    required http.Client httpClient,
    required Future<String> Function() installationId,
    LinguaFlowDeviceIntegrityProvider? integrityProvider,
  })  : _config = config,
        _http = httpClient,
        _installationId = installationId,
        _integrityProvider = integrityProvider;

  final LinguaFlowConfig _config;
  final http.Client _http;
  final Future<String> Function() _installationId;
  final LinguaFlowDeviceIntegrityProvider? _integrityProvider;
  LinguaFlowIntegrityGrant? _integrityGrant;

  Future<LocaleManifest> manifest({
    required String locale,
    required bool explicit,
  }) async {
    final response = await sendSafeHttpRequest(
      _http,
      'GET',
      _bundleUri('manifest'),
      headers: await _headers({
        explicit ? 'x-linguaflow-locale' : 'x-linguaflow-device-locale': locale,
      }),
      maxResponseBytes: _maxManifestBytes,
    );
    _ensureSuccess(response, 'Unable to resolve locale');
    return LocaleManifest.fromJson(_decodeJsonObject(response.body));
  }

  Future<BundleDelivery> bundle({
    required String locale,
    String? etag,
  }) async {
    final response = await sendSafeHttpRequest(
      _http,
      'GET',
      _bundleUri(),
      headers: await _headers({
        'x-linguaflow-locale': locale,
        if (etag != null) 'if-none-match': etag,
      }),
      maxResponseBytes: _maxBundleBytes,
    );
    if (response.statusCode == 304) return const BundleNotModified();
    _ensureSuccess(response, 'Unable to download $locale bundle');
    return BundleContent(
        _decodeBundle(response.body), response.headers['etag']);
  }

  Future<void> reportMissingKeys(MissingKeysReport report) async {
    final uri = Uri.parse(linguaflowApiOrigin).resolve(
      '/v1/telemetry/${Uri.encodeComponent(_config.branchKey)}/missing-keys',
    );
    final response = await sendSafeHttpRequest(
      _http,
      'POST',
      uri,
      headers: await _headers({
        'content-type': 'application/json',
        'x-linguaflow-telemetry-token': report.telemetryToken,
      }),
      body: jsonEncode(report.toJson()),
      maxResponseBytes: _maxTelemetryResponseBytes,
    );
    _ensureSuccess(response, 'Missing-key telemetry failed');
  }

  Future<void> reportRuntimeMetrics({
    required String requestId,
    required String telemetryToken,
    required String appVersion,
    required List<contract.RuntimeMetricItemDto> metrics,
  }) async {
    final uri = Uri.parse(linguaflowApiOrigin).resolve(
      '/v1/telemetry/${Uri.encodeComponent(_config.branchKey)}/runtime-metrics',
    );
    final response = await sendSafeHttpRequest(_http, 'POST', uri,
        headers: await _headers({
          'content-type': 'application/json',
          'x-linguaflow-telemetry-token': telemetryToken,
        }),
        body: jsonEncode(contract.RuntimeMetricReportRequestDto(
          requestId: requestId,
          appVersion: appVersion,
          metrics: metrics,
        ).toJson()),
        maxResponseBytes: _maxTelemetryResponseBytes);
    _ensureSuccess(response, 'Runtime telemetry failed');
  }

  Uri _bundleUri([String? suffix]) {
    final path = '/v1/bundles/${Uri.encodeComponent(_config.branchKey)}'
        '${suffix == null ? '' : '/$suffix'}';
    return Uri.parse(linguaflowApiOrigin).resolve(path);
  }

  Future<Map<String, String>> _headers(Map<String, String> input) async {
    final headers = {
      ...input,
      'x-linguaflow-installation-id': await _installationId(),
      'x-linguaflow-sdk': 'flutter',
      'x-linguaflow-sdk-version': linguaFlowFlutterSdkVersion,
      'x-linguaflow-contract-version':
          linguaFlowRuntimeContractVersion.toString(),
      if (_config.overlay != null) 'x-linguaflow-overlay': _config.overlay!,
    };
    final provider = _integrityProvider;
    if (provider == null) return headers;
    var grant = _integrityGrant;
    if (grant == null || !grant.isUsable) {
      grant = await provider.obtainGrant(branchKey: _config.branchKey);
      _integrityGrant = grant;
    }
    return {...headers, 'x-linguaflow-integrity': grant.token};
  }

  void _ensureSuccess(http.Response response, String operation) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LinguaFlowException(operation, response.statusCode);
    }
  }

  Map<String, dynamic> _decodeJsonObject(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is! Map) throw const FormatException();
      return decoded.cast<String, dynamic>();
    } on Object {
      throw BundlePayloadException();
    }
  }

  TranslationBundle _decodeBundle(String body) {
    try {
      return decodeTranslationBundle(jsonDecode(body));
    } on Object {
      throw BundlePayloadException();
    }
  }
}

TranslationBundle decodeTranslationBundle(Object? value) {
  if (value is! Map) throw const FormatException('Bundle must be an object.');
  final root = value.cast<String, dynamic>();
  final pending = <({Map<String, dynamic> value, int depth})>[
    (value: root, depth: 0)
  ];
  var valueCount = 0;
  while (pending.isNotEmpty) {
    final current = pending.removeLast();
    if (current.depth > _maxBundleDepth) {
      throw const FormatException('Bundle is too deeply nested.');
    }
    for (final entry in current.value.entries) {
      valueCount++;
      if (valueCount > _maxBundleValues) {
        throw const FormatException('Bundle has too many values.');
      }
      if (entry.key.isEmpty || _unsafeObjectKeys.contains(entry.key)) {
        throw const FormatException('Bundle contains an unsafe key.');
      }
      if (entry.value is String) continue;
      if (entry.value is! Map) {
        throw const FormatException(
            'Bundle values must be strings or objects.');
      }
      pending.add((
        value: (entry.value as Map).cast<String, dynamic>(),
        depth: current.depth + 1,
      ));
    }
  }
  return root;
}
