import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'device_integrity.dart';
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';

class PlayIntegrityProvider implements LinguaFlowDeviceIntegrityProvider {
  PlayIntegrityProvider({
    http.Client? httpClient,
    @visibleForTesting PlayIntegrityPlatform? platform,
  })  : _http = httpClient ?? http.Client(),
        _ownsHttpClient = httpClient == null,
        _platform = platform ?? const MethodChannelPlayIntegrityPlatform();

  final http.Client _http;
  final bool _ownsHttpClient;
  final PlayIntegrityPlatform _platform;
  final Map<String, LinguaFlowIntegrityGrant> _grants = {};
  final Map<String, Future<LinguaFlowIntegrityGrant>> _pending = {};

  @override
  Future<LinguaFlowIntegrityGrant> obtainGrant({required String branchKey}) {
    final cached = _grants[branchKey];
    if (cached?.isUsable == true) return Future.value(cached);
    return _pending.putIfAbsent(branchKey, () async {
      try {
        final challenge = await _challenge(branchKey);
        final token = await _platform.requestToken(
          cloudProjectNumber: challenge.cloudProjectNumber,
          requestHash: challenge.requestHash,
        );
        final grant = await _exchange(branchKey, challenge.challengeId, token);
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

  Future<PlayIntegrityChallenge> _challenge(String branchKey) async {
    final packageName = await _platform.packageName();
    return PlayIntegrityChallenge.fromJson(
      await _post(branchKey, 'challenges', {'packageName': packageName}),
    );
  }

  Future<LinguaFlowIntegrityGrant> _exchange(
    String branchKey,
    String challengeId,
    String integrityToken,
  ) async {
    final body = await _post(branchKey, 'tokens', {
      'packageName': await _platform.packageName(),
      'challengeId': challengeId,
      'integrityToken': integrityToken,
    });
    final expiresAt =
        DateTime.tryParse(_requiredJsonString(body, 'expiresAt'))?.toUtc();
    if (expiresAt == null) {
      throw LinguaFlowException('Invalid Play Integrity grant expiry', null);
    }
    return LinguaFlowIntegrityGrant(
      token: _requiredJsonString(body, 'token'),
      expiresAt: expiresAt,
    );
  }

  Future<Map<String, dynamic>> _post(
    String branchKey,
    String operation,
    Map<String, String> payload,
  ) async {
    final uri = Uri.parse(linguaflowApiOrigin).resolve(
      '/v1/bundles/${Uri.encodeComponent(branchKey)}/attestation/android/$operation',
    );
    final response = await _http
        .post(uri,
            headers: const {
              'content-type': 'application/json',
              'x-linguaflow-sdk': 'flutter',
              'x-linguaflow-sdk-version': linguaFlowFlutterSdkVersion,
              'x-linguaflow-contract-version': '1',
            },
            body: jsonEncode(payload))
        .timeout(const Duration(seconds: 60));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw LinguaFlowException(
          'Play Integrity exchange failed', response.statusCode);
    }
    try {
      return (jsonDecode(response.body) as Map).cast<String, dynamic>();
    } on Object {
      throw LinguaFlowException('Invalid Play Integrity response', null);
    }
  }
}

@immutable
class PlayIntegrityChallenge {
  const PlayIntegrityChallenge({
    required this.challengeId,
    required this.requestHash,
    required this.cloudProjectNumber,
    required this.expiresAt,
  });

  factory PlayIntegrityChallenge.fromJson(Map<String, dynamic> json) {
    final project =
        int.tryParse(_requiredJsonString(json, 'cloudProjectNumber'));
    final expiry =
        DateTime.tryParse(_requiredJsonString(json, 'expiresAt'))?.toUtc();
    if (project == null || expiry == null) {
      throw LinguaFlowException('Invalid Play Integrity challenge', null);
    }
    return PlayIntegrityChallenge(
      challengeId: _requiredJsonString(json, 'challengeId'),
      requestHash: _requiredJsonString(json, 'requestHash'),
      cloudProjectNumber: project,
      expiresAt: expiry,
    );
  }

  final String challengeId;
  final String requestHash;
  final int cloudProjectNumber;
  final DateTime expiresAt;
}

String _requiredJsonString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is! String || value.isEmpty) {
    throw LinguaFlowException('Invalid Play Integrity response', null);
  }
  return value;
}

@visibleForTesting
abstract interface class PlayIntegrityPlatform {
  Future<String> packageName();
  Future<String> requestToken(
      {required int cloudProjectNumber, required String requestHash});
}

class MethodChannelPlayIntegrityPlatform implements PlayIntegrityPlatform {
  const MethodChannelPlayIntegrityPlatform();

  static const _channel = MethodChannel('dev.linguaflow/play_integrity');

  @override
  Future<String> packageName() => _requiredString('packageName');

  @override
  Future<String> requestToken(
          {required int cloudProjectNumber, required String requestHash}) =>
      _requiredString('requestToken', {
        'cloudProjectNumber': cloudProjectNumber,
        'requestHash': requestHash,
      });

  Future<String> _requiredString(String method,
      [Map<String, Object>? arguments]) async {
    final value = await _channel.invokeMethod<String>(method, arguments);
    if (value == null || value.isEmpty) {
      throw LinguaFlowException(
          'Invalid Play Integrity platform response', null);
    }
    return value;
  }
}
