import 'dart:async';
import 'dart:math';

import 'delivery_api.dart';
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';

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
  final Set<String> _pending = {};
  Timer? _timer;

  void record(String key) {
    final manifest = _manifest();
    if (!_config.missingKeyTelemetryEnabled ||
        manifest == null ||
        !manifest.missingKeyTelemetryEnabled) return;
    _pending.add(key);
    _timer ??= Timer(
      const Duration(milliseconds: 500),
      () => unawaited(flush()),
    );
  }

  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    final manifest = _manifest();
    if (manifest == null || _pending.isEmpty) return;
    final limit = min(manifest.missingKeyTelemetryMaxBatchSize, 100);
    final keys = _pending.take(limit).toList();
    _pending.removeAll(keys);
    try {
      await _api.reportMissingKeys(
        MissingKeysReport(
          requestId: _uuid(),
          releaseId: manifest.releaseId,
          locale: manifest.resolvedLocale,
          appVersion: _config.appVersion,
          keys: keys,
        ),
      );
    } on Object {
      _pending.addAll(keys);
    }
    if (_pending.isNotEmpty) {
      _timer = Timer(const Duration(seconds: 5), () => unawaited(flush()));
    }
  }

  void dispose() => _timer?.cancel();
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
