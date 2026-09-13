import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:linguaflow_sdk/linguaflow_sdk.dart';

void main() {
  test('exchanges a Play Integrity Standard token and caches the grant',
      () async {
    final platform = FakePlayIntegrityPlatform();
    var requests = 0;
    final provider = PlayIntegrityProvider(
      platform: platform,
      httpClient: MockClient((request) async {
        requests++;
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['packageName'], 'dev.linguaflow.example');
        if (request.url.path.endsWith('/challenges')) {
          return http.Response(
            jsonEncode({
              'challengeId': '11111111-1111-4111-8111-111111111111',
              'requestHash': 'server-bound-request-hash',
              'cloudProjectNumber': '123456789',
              'expiresAt': DateTime.now()
                  .add(const Duration(minutes: 2))
                  .toIso8601String(),
            }),
            201,
          );
        }
        expect(body['integrityToken'], 'google-integrity-token');
        return http.Response(
          jsonEncode({
            'token': 'delivery-grant',
            'expiresAt': DateTime.now()
                .add(const Duration(minutes: 5))
                .toIso8601String(),
          }),
          201,
        );
      }),
    );
    final first = await provider.obtainGrant(branchKey: 'br_live_example');
    final second = await provider.obtainGrant(branchKey: 'br_live_example');
    expect(first.token, 'delivery-grant');
    expect(second.token, 'delivery-grant');
    expect(platform.projectNumber, 123456789);
    expect(platform.requestHash, 'server-bound-request-hash');
    expect(requests, 2);
    provider.close();
  });
}

class FakePlayIntegrityPlatform implements PlayIntegrityPlatform {
  int? projectNumber;
  String? requestHash;
  @override
  Future<String> packageName() async => 'dev.linguaflow.example';
  @override
  Future<String> requestToken(
      {required int cloudProjectNumber, required String requestHash}) async {
    projectNumber = cloudProjectNumber;
    this.requestHash = requestHash;
    return 'google-integrity-token';
  }
}
