import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'device_integrity.dart';
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';
import 'safe_http_client.dart';

const _maxIntegrityResponseBytes = 256 * 1024;

enum AppAttestEnvironment { development, production }

class AppAttestIntegrityProvider implements LinguaFlowDeviceIntegrityProvider {
  AppAttestIntegrityProvider({
    this.environment = AppAttestEnvironment.production,
    http.Client? httpClient,
    @visibleForTesting AppAttestPlatform? platform,
  })  : _http = httpClient ?? http.Client(),
        _ownsHttpClient = httpClient == null,
        _platform = platform ?? const MethodChannelAppAttestPlatform();

  final AppAttestEnvironment environment;
  final http.Client _http;
  final bool _ownsHttpClient;
  final AppAttestPlatform _platform;
  final Map<String, LinguaFlowIntegrityGrant> _grants = {};
  final Map<String, Future<LinguaFlowIntegrityGrant>> _pending = {};

  @override
  Future<LinguaFlowIntegrityGrant> obtainGrant({
    required String branchKey,
  }) {
    final cached = _grants[branchKey];
    if (cached?.isUsable == true) return Future.value(cached);
    return _pending.putIfAbsent(branchKey, () async {
      try {
        final grant = await _exchange(branchKey, mayRecoverKey: true);
        _grants[branchKey] = grant;
        return grant;
      } finally {
        _pending.remove(branchKey);
      }
    });
  }

  void close() {
    if (_ownsHttpClient) _http.close();
  }

  Future<LinguaFlowIntegrityGrant> _exchange(
    String branchKey, {
    required bool mayRecoverKey,
  }) async {
    if (!await _platform.isSupported()) {
      throw LinguaFlowException('Apple App Attest is unavailable', null);
    }
    final bundleId = await _platform.bundleIdentifier();
    final challenge = await _post(
      branchKey,
      'challenges',
      {'bundleId': bundleId, 'environment': environment.name},
    );
    final challengeId = challenge.body.string('challengeId');
    final challengeValue = challenge.body.string('challenge');
    final storedKeyId = await _platform.storedKeyId(environment);
    final keyId = storedKeyId ?? await _platform.generateKey();
    final isRegistration = storedKeyId == null;
    late final String proof;
    try {
      proof = isRegistration
          ? await _platform.attest(keyId, challengeValue)
          : await _platform.assertion(keyId, challengeValue);
    } on PlatformException {
      if (isRegistration || !mayRecoverKey) rethrow;
      await _platform.clearKey(environment);
      return _exchange(branchKey, mayRecoverKey: false);
    }
    final response = await _post(
      branchKey,
      isRegistration ? 'keys' : 'assertions',
      {
        'bundleId': bundleId,
        'environment': environment.name,
        'challengeId': challengeId,
        'challenge': challengeValue,
        'keyId': keyId,
        isRegistration ? 'attestation' : 'assertion': proof,
      },
      acceptedError: !isRegistration && mayRecoverKey ? 401 : null,
    );
    if (response.statusCode == 401) {
      await _platform.clearKey(environment);
      return _exchange(branchKey, mayRecoverKey: false);
    }
    if (isRegistration) await _platform.storeKey(environment, keyId);
    final body = response.body;
    final expiresAt = DateTime.tryParse(body.string('expiresAt'))?.toUtc();
    if (expiresAt == null) {
      throw LinguaFlowException('Invalid App Attest grant expiry', null);
    }
    return LinguaFlowIntegrityGrant(
      token: body.string('token'),
      expiresAt: expiresAt,
    );
  }

  Future<_JsonResponse> _post(
    String branchKey,
    String operation,
    Map<String, String> payload, {
    int? acceptedError,
  }) async {
    final uri = Uri.parse(linguaflowApiOrigin).resolve(
      '/v1/bundles/${Uri.encodeComponent(branchKey)}/attestation/apple/$operation',
    );
    final response = await sendSafeHttpRequest(
      _http,
      'POST',
      uri,
      headers: const {
        'content-type': 'application/json',
        'x-linguaflow-sdk': 'flutter',
        'x-linguaflow-sdk-version': linguaFlowFlutterSdkVersion,
        'x-linguaflow-contract-version': '$linguaFlowRuntimeContractVersion',
      },
      body: jsonEncode(payload),
      maxResponseBytes: _maxIntegrityResponseBytes,
      timeout: const Duration(seconds: 15),
    );
    if (response.statusCode == acceptedError) {
      return _JsonResponse(response.statusCode, const {});
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LinguaFlowException(
        'App Attest exchange failed',
        response.statusCode,
      );
    }
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is! Map) throw const FormatException();
      return _JsonResponse(
          response.statusCode, decoded.cast<String, dynamic>());
    } on Object {
      throw LinguaFlowException('Invalid App Attest response', null);
    }
  }
}

@visibleForTesting
abstract interface class AppAttestPlatform {
  Future<bool> isSupported();
  Future<String> bundleIdentifier();
  Future<String?> storedKeyId(AppAttestEnvironment environment);
  Future<String> generateKey();
  Future<String> attest(String keyId, String challenge);
  Future<String> assertion(String keyId, String challenge);
  Future<void> storeKey(AppAttestEnvironment environment, String keyId);
  Future<void> clearKey(AppAttestEnvironment environment);
}

class MethodChannelAppAttestPlatform implements AppAttestPlatform {
  const MethodChannelAppAttestPlatform();

  static const _channel = MethodChannel('dev.linguaflow/app_attest');

  @override
  Future<bool> isSupported() async =>
      await _channel.invokeMethod<bool>('isSupported') ?? false;

  @override
  Future<String> bundleIdentifier() => _requiredString('bundleIdentifier');

  @override
  Future<String?> storedKeyId(AppAttestEnvironment environment) => _channel
      .invokeMethod<String>('storedKeyId', {'environment': environment.name});

  @override
  Future<String> generateKey() => _requiredString('generateKey');

  @override
  Future<String> attest(String keyId, String challenge) => _requiredString(
        'attest',
        {'keyId': keyId, 'challenge': challenge},
      );

  @override
  Future<String> assertion(String keyId, String challenge) => _requiredString(
        'assertion',
        {'keyId': keyId, 'challenge': challenge},
      );

  @override
  Future<void> storeKey(AppAttestEnvironment environment, String keyId) =>
      _channel.invokeMethod<void>('storeKey', {
        'environment': environment.name,
        'keyId': keyId,
      });

  @override
  Future<void> clearKey(AppAttestEnvironment environment) => _channel
      .invokeMethod<void>('clearKey', {'environment': environment.name});

  Future<String> _requiredString(
    String method, [
    Map<String, String>? arguments,
  ]) async {
    final result = await _channel.invokeMethod<String>(method, arguments);
    if (result == null || result.isEmpty) {
      throw LinguaFlowException('Invalid App Attest platform response', null);
    }
    return result;
  }
}

class _JsonResponse {
  const _JsonResponse(this.statusCode, this.body);

  final int statusCode;
  final Map<String, dynamic> body;
}

extension on Map<String, dynamic> {
  String string(String key) {
    final value = this[key];
    if (value is! String || value.isEmpty) {
      throw LinguaFlowException('Invalid App Attest response', null);
    }
    return value;
  }
}
