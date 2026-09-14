import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:linguaflow_sdk/linguaflow_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('resolves dotted typed paths', () {
    final client = LinguaFlowClient(
        config: const LinguaFlowConfig(branchKey: 'br_live_demo'));
    expect(
        client.lookup(const LfKey('home.hero.title'), bundle: {
          'home': {
            'hero': {'title': 'Hello'}
          }
        }),
        'Hello');
    expect(
        client.lookup(const LfKey('home.greeting'), arguments: {
          'name': 'Ada'
        }, bundle: {
          'home': {'greeting': 'Hello, {name}!'}
        }),
        'Hello, Ada!');
    expect(client.lookup(const LfKey('missing.key'), bundle: {'home': {}}),
        isNull);
    client.dispose();
  });

  test('formats ICU plural messages with typed message arguments', () {
    final client = LinguaFlowClient(
      config: const LinguaFlowConfig(branchKey: 'br_live_demo'),
    );
    final key = LfMessage('cart.items', {'count': 2});
    expect(
      client.lookup(
        key,
        bundle: {
          'cart': {
            'items': '{count, plural, one {One item} other {# items}}',
          },
        },
      ),
      '2 items',
    );
    client.dispose();
  });

  test(
      'resolves device locale and avoids bundle download when release is cached',
      () async {
    var bundleRequests = 0;
    final httpClient = MockClient((request) async {
      if (request.url.path.endsWith('/manifest')) {
        expect(request.headers['x-linguaflow-device-locale'], 'tr-TR');
        expect(request.headers['x-linguaflow-contract-version'], '2');
        expect(request.headers['x-linguaflow-installation-id'],
            matches(RegExp(r'^[a-f0-9]{32}$')));
        return http.Response(
          _manifestJson(
              releaseId: 'rel_1',
              requested: 'tr-TR',
              resolved: 'tr',
              reason: 'device',
              supported: ['en', 'tr']),
          200,
        );
      }
      bundleRequests++;
      return http.Response(
        '{"home":{"title":"Merhaba"}}',
        200,
        headers: {'etag': '"rel_1"'},
      );
    });
    final first = LinguaFlowClient(
      config: const LinguaFlowConfig(branchKey: 'br_live_demo'),
      httpClient: httpClient,
    );
    await first.initialize(deviceLocale: 'tr-TR');
    expect(first.activeLocale, 'tr');
    expect(first.supportedLocales, ['en', 'tr']);
    expect(first.bundleSource, LinguaFlowBundleSource.remote);
    first.dispose();

    final second = LinguaFlowClient(
      config: const LinguaFlowConfig(branchKey: 'br_live_demo'),
      httpClient: httpClient,
    );
    await second.initialize(deviceLocale: 'tr-TR');
    expect(second.lookup(const LfKey('home.title')), 'Merhaba');
    expect(second.bundleSource, LinguaFlowBundleSource.downloaded);
    expect(bundleRequests, 1);
    second.dispose();
  });

  test('removed explicit locale falls back and clears persisted selection',
      () async {
    final client = LinguaFlowClient(
      config: const LinguaFlowConfig(branchKey: 'br_live_removed'),
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/manifest')) {
          return http.Response(
            _manifestJson(
                releaseId: 'rel_2',
                requested: 'de',
                resolved: 'en',
                reason: 'fallback',
                supported: ['en', 'tr']),
            200,
          );
        }
        return http.Response('{"title":"Fallback"}', 200);
      }),
    );
    await client.selectLocale('de');
    expect(client.activeLocale, 'en');
    expect(client.selectedLocale, isNull);
    client.dispose();
  });

  test(
      'mapped explicit locale is retained even when it resolves to fallback language',
      () async {
    final client = LinguaFlowClient(
      config: const LinguaFlowConfig(branchKey: 'br_live_mapped'),
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/manifest')) {
          return http.Response(
            _manifestJson(
                releaseId: 'rel_3',
                requested: 'ar',
                resolved: 'en',
                reason: 'mapped',
                supported: ['en', 'ar'],
                translated: ['en'],
                mappings: {'ar': 'en'}),
            200,
          );
        }
        return http.Response('{"title":"Mapped"}', 200);
      }),
    );
    await client.selectLocale('ar');
    expect(client.selectedLocale, 'ar');
    expect(client.activeLocale, 'ar');
    expect(client.resolvedLocale, 'en');
    expect(client.supportedLocales, ['en', 'ar']);
    client.dispose();
  });

  test('normalizes configured locale mapping keys', () {
    final manifest = LocaleManifest.fromJson({
      'version': 2,
      'releaseId': 'rel_4',
      'sequence': 1,
      'requestedLocale': 'ar-SA',
      'resolvedLocale': 'he',
      'reason': 'mapped',
      'supportedLocales': ['en', 'he'],
      'fallbackLocale': 'en',
      'localeMappings': {'ar-SA': 'he'},
      'translatedLocales': ['en', 'he'],
      'rollout': {
        'candidateReleaseId': 'rel_4',
        'percentage': 100,
        'selection': 'stable'
      },
      'bundlePath': 'releases/rel_4/he.json',
      'overlays': <String>[],
      'overlay': null,
      'missingKeyTelemetry': {'enabled': false, 'maxBatchSize': 100},
      'runtimeTelemetry': null,
    });
    expect(manifest.localeMappings['ar-sa'], 'he');
  });

  test('rejects unknown locale resolution reasons', () {
    expect(
      () => LocaleManifest.fromJson({
        'version': 2,
        'releaseId': 'rel_invalid',
        'resolvedLocale': 'en',
        'reason': 'guessed',
        'supportedLocales': ['en'],
        'fallbackLocale': 'en',
        'localeMappings': <String, String>{},
      }),
      throwsA(isA<LinguaFlowException>()),
    );
  });

  test('rejects unknown runtime contract versions', () {
    expect(
      () => LocaleManifest.fromJson({'version': 1}),
      throwsA(isA<LinguaFlowException>()),
    );
  });

  test('rejects an invalid shared config', () {
    expect(
      () => LinguaFlowConfig.fromJson({'branchKey': 'not-public'}),
      throwsFormatException,
    );
  });

  test('rejects invalid directly constructed config before network access', () {
    expect(
      () => LinguaFlowClient(
        config: const LinguaFlowConfig(branchKey: 'secret'),
      ),
      throwsArgumentError,
    );
    expect(
      () => LinguaFlowClient(
        config: const LinguaFlowConfig(
          branchKey: 'br_live_test',
          bundledAssetPath: '../secrets',
        ),
      ),
      throwsArgumentError,
    );
  });

  test('rejects non-string translation bundle leaves', () async {
    final client = LinguaFlowClient(
      config: const LinguaFlowConfig(
        branchKey: 'br_live_payload',
        offlineEnabled: false,
      ),
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/manifest')) {
          return http.Response(
            _manifestJson(
              releaseId: 'rel_payload',
              requested: 'en',
              resolved: 'en',
              reason: 'device',
              supported: ['en'],
            ),
            200,
          );
        }
        return http.Response('{"home":{"title":42}}', 200);
      }),
    );

    await expectLater(client.initialize(deviceLocale: 'en'),
        throwsA(isA<LinguaFlowException>()));
    client.dispose();
  });

  test('batches opted-in missing key telemetry', () async {
    Map<String, dynamic>? report;
    final client = LinguaFlowClient(
      config: const LinguaFlowConfig(
        branchKey: 'br_live_telemetry',
        missingKeyTelemetryEnabled: true,
        appVersion: '2.0.0',
      ),
      httpClient: MockClient((request) async {
        if (request.url.path.endsWith('/manifest')) {
          return http.Response(
            _manifestJson(
                releaseId: '11111111-1111-4111-8111-111111111111',
                requested: 'tr',
                resolved: 'tr',
                reason: 'selected',
                supported: ['tr'],
                fallback: 'tr',
                telemetry: true),
            200,
          );
        }
        if (request.url.path.contains('/telemetry/')) {
          report = jsonDecode(request.body) as Map<String, dynamic>;
          return http.Response('{"accepted":true}', 201);
        }
        return http.Response('{}', 200);
      }),
    );
    await client.initialize(deviceLocale: 'tr');
    client.resolve(const LfKey('checkout.pay'));
    client.resolve(const LfKey('checkout.pay'));
    await client.flushMissingKeys();
    expect(report?['keys'], ['checkout.pay']);
    expect(report?['appVersion'], '2.0.0');
    client.dispose();
  });
}

String _manifestJson({
  required String releaseId,
  required String requested,
  required String resolved,
  required String reason,
  required List<String> supported,
  List<String>? translated,
  String fallback = 'en',
  Map<String, String> mappings = const {},
  bool telemetry = false,
}) =>
    jsonEncode({
      'version': 2,
      'releaseId': releaseId,
      'sequence': 1,
      'requestedLocale': requested,
      'resolvedLocale': resolved,
      'reason': reason,
      'supportedLocales': supported,
      'translatedLocales': translated ?? supported,
      'fallbackLocale': fallback,
      'localeMappings': mappings,
      'rollout': {
        'candidateReleaseId': releaseId,
        'percentage': 100,
        'selection': 'stable',
      },
      'bundlePath': 'releases/$releaseId/$resolved.json',
      'overlays': <String>[],
      'overlay': null,
      'missingKeyTelemetry': {'enabled': telemetry, 'maxBatchSize': 100},
      'runtimeTelemetry': {
        'token': 'telemetry-token',
        'expiresAt':
            DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
      },
    });
