import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:linguaflow_sdk/linguaflow_sdk.dart';

void main() {
  test('registers a new App Attest key and caches the branch grant', () async {
    final platform = FakeAppAttestPlatform();
    var requests = 0;
    final provider = AppAttestIntegrityProvider(
      environment: AppAttestEnvironment.development,
      platform: platform,
      httpClient: MockClient((request) async {
        requests++;
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['bundleId'], 'dev.linguaflow.example');
        expect(body['environment'], 'development');
        if (request.url.path.endsWith('/challenges')) {
          return http.Response(
            '{"challengeId":"11111111-1111-4111-8111-111111111111","challenge":"server-challenge-with-enough-entropy"}',
            201,
          );
        }
        expect(request.url.path, endsWith('/keys'));
        expect(body['keyId'], 'generated-key');
        expect(body['attestation'], 'attestation-proof');
        return grantResponse('grant-one');
      }),
    );

    final first = await provider.obtainGrant(
      branchKey: 'br_live_example',
    );
    final second = await provider.obtainGrant(
      branchKey: 'br_live_example',
    );

    expect(first.token, 'grant-one');
    expect(second.token, 'grant-one');
    expect(platform.stored, 'generated-key');
    expect(requests, 2);
    provider.close();
  });

  test('re-attests once when the server no longer recognizes a stored key',
      () async {
    final platform = FakeAppAttestPlatform()..stored = 'stale-key';
    var challenges = 0;
    final provider = AppAttestIntegrityProvider(
      platform: platform,
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/challenges')) {
          challenges++;
          return http.Response(
            '{"challengeId":"11111111-1111-4111-8111-111111111111","challenge":"server-challenge-with-enough-entropy"}',
            201,
          );
        }
        if (request.url.path.endsWith('/assertions'))
          return http.Response('{}', 401);
        return grantResponse('recovered-grant');
      }),
    );

    final grant = await provider.obtainGrant(
      branchKey: 'br_live_example',
    );

    expect(grant.token, 'recovered-grant');
    expect(platform.clearCount, 1);
    expect(platform.stored, 'generated-key');
    expect(challenges, 2);
    provider.close();
  });
}

http.Response grantResponse(String token) => http.Response(
      jsonEncode({
        'token': token,
        'expiresAt':
            DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
      }),
      201,
    );

class FakeAppAttestPlatform implements AppAttestPlatform {
  String? stored;
  int clearCount = 0;

  @override
  Future<String> assertion(String keyId, String challenge) async =>
      'assertion-proof';

  @override
  Future<String> attest(String keyId, String challenge) async =>
      'attestation-proof';

  @override
  Future<String> bundleIdentifier() async => 'dev.linguaflow.example';

  @override
  Future<void> clearKey(AppAttestEnvironment environment) async {
    clearCount++;
    stored = null;
  }

  @override
  Future<String> generateKey() async => 'generated-key';

  @override
  Future<bool> isSupported() async => true;

  @override
  Future<void> storeKey(AppAttestEnvironment environment, String keyId) async {
    stored = keyId;
  }

  @override
  Future<String?> storedKeyId(AppAttestEnvironment environment) async => stored;
}
