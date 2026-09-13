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
    final offline =
        (json['offline'] as Map? ?? const {}).cast<String, dynamic>();
    final missing = offline['missingTranslation'] as String? ?? 'fallback';
    final branchKey = json['branchKey'];
    final overlay = json['overlay'];
    final cacheTtlSeconds = json['cacheTtlSeconds'] as int? ?? 300;
    final telemetry =
        (json['telemetry'] as Map? ?? const {}).cast<String, dynamic>();
    if (branchKey is! String || !branchKey.startsWith('br_live_')) {
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
      bundledAssetPath: json['bundledPath'] as String? ?? 'assets/linguaflow',
      offlineEnabled: offline['enabled'] as bool? ?? true,
      missingTranslationBehavior: switch (missing) {
        'key' => MissingTranslationBehavior.key,
        'empty' => MissingTranslationBehavior.empty,
        'throw' => MissingTranslationBehavior.throwException,
        _ => MissingTranslationBehavior.fallback,
      },
      generatorOutput:
          json['output'] as String? ?? 'lib/generated/linguaflow_keys.dart',
      overlay: overlay as String?,
      missingKeyTelemetryEnabled: telemetry['missingKeys'] as bool? ?? false,
      appVersion: telemetry['appVersion'] as String? ?? '',
    );
  }

  static Future<LinguaFlowConfig> load({
    AssetBundle? assetBundle,
    String path = '.linguaconfig',
  }) async {
    final raw = await (assetBundle ?? rootBundle).loadString(path);
    return LinguaFlowConfig.fromJson(jsonDecode(raw) as Map<String, dynamic>);
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
}

enum LinguaFlowBundleSource { remote, downloaded, bundled }
