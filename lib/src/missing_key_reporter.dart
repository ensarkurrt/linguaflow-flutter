import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'delivery_api.dart';
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';

typedef _MissingKeyContext = ({
  String releaseId,
  String locale,
  String token,
  int maxBatchSize,
});

class _MissingKeyBatch {
  const _MissingKeyBatch(this.requestId, this.context, this.keys,
      [this.attempts = 0]);
  final String requestId;
  final _MissingKeyContext context;
  final List<String> keys;
  final int attempts;
}

class MissingKeyReporter {
  MissingKeyReporter({
    required LinguaFlowConfig config,
    required DeliveryApi api,
    required LocaleManifest? Function() manifest,
  })  : _config = config,
        _api = api,
        _manifest = manifest;

  final LinguaFlowConfig _config;
  final DeliveryApi _api;
  final LocaleManifest? Function() _manifest;
  final Map<_MissingKeyContext, Set<String>> _pending = {};
  final List<_MissingKeyBatch> _retries = [];
  Timer? _timer;
  Future<String>? _nativeAppVersion;

  void record(String key) {
    final manifest = _manifest();
    final token = manifest?.runtimeTelemetryToken;
    if (!_config.missingKeyTelemetryEnabled ||
        manifest == null ||
        !manifest.missingKeyTelemetryEnabled ||
        token == null) return;
    final context = (
      releaseId: manifest.releaseId,
      locale: manifest.resolvedLocale,
      token: token,
      maxBatchSize: min(manifest.missingKeyTelemetryMaxBatchSize, 100),
    );
    _pending.putIfAbsent(context, () => {}).add(key);
    _schedule(const Duration(milliseconds: 500));
  }

  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    final batches = [..._retries];
    _retries.clear();
    for (final context in [..._pending.keys]) {
      final keys = _pending[context]!;
      final selected = keys.take(context.maxBatchSize).toList();
      keys.removeAll(selected);
      if (keys.isEmpty) _pending.remove(context);
      if (selected.isNotEmpty) {
        batches.add(_MissingKeyBatch(_uuid(), context, selected));
      }
    }
    for (final batch in batches) {
      try {
        await _api.reportMissingKeys(MissingKeysReport(
          requestId: batch.requestId,
          locale: batch.context.locale,
          appVersion: await _appVersion(),
          telemetryToken: batch.context.token,
          keys: batch.keys,
        ));
      } on Object {
        if (batch.attempts < 3) {
          _retries.add(_MissingKeyBatch(
              batch.requestId, batch.context, batch.keys, batch.attempts + 1));
        }
      }
    }
    if (_pending.isNotEmpty || _retries.isNotEmpty) {
      _schedule(const Duration(seconds: 5));
    }
  }

  void dispose() => _timer?.cancel();

  void _schedule(Duration delay) =>
      _timer ??= Timer(delay, () => unawaited(flush()));

  Future<String> _appVersion() {
    if (_config.appVersion.isNotEmpty) return Future.value(_config.appVersion);
    return _nativeAppVersion ??= _readNativeAppVersion();
  }

  Future<String> _readNativeAppVersion() async {
    try {
      final channel = MethodChannel(defaultTargetPlatform == TargetPlatform.iOS
          ? 'dev.linguaflow/app_attest'
          : 'dev.linguaflow/play_integrity');
      final value =
          await channel.invokeMapMethod<String, dynamic>('appVersion');
      final name = value?['name']?.toString() ?? '';
      final code = value?['code']?.toString() ?? '';
      if (name.isNotEmpty && code.isNotEmpty) return '$name ($code)';
      return name.isNotEmpty ? name : code;
    } on Object {
      return '';
    }
  }
}

String _uuid() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final value =
      bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  return '${value.substring(0, 8)}-${value.substring(8, 12)}-'
      '${value.substring(12, 16)}-${value.substring(16, 20)}-'
      '${value.substring(20)}';
}
