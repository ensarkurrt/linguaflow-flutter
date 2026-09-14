import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'delivery_api.dart';
import 'generated/runtime_contract/api.dart' as contract;
import 'linguaflow_config.dart';
import 'linguaflow_models.dart';

typedef _TelemetryContext = ({String releaseId, String token});

class _RuntimeMetricBatch {
  final String requestId;
  final _TelemetryContext context;
  final List<contract.RuntimeMetricItemDto> metrics;
  final int attempts;

  const _RuntimeMetricBatch(this.requestId, this.context, this.metrics,
      [this.attempts = 0]);
}

class RuntimeMetricReporter {
  RuntimeMetricReporter(
      {required this.config,
      required this.api,
      required this.manifest,
      required this.enabled});

  final LinguaFlowConfig config;
  final DeliveryApi api;
  final LocaleManifest? Function() manifest;
  final bool enabled;
  final Map<
      _TelemetryContext,
      Map<
          (
            contract.RuntimeMetricItemDtoKindEnum,
            contract.RuntimeMetricItemDtoOutcomeEnum
          ),
          int>> _pending = {};
  final List<_RuntimeMetricBatch> _retries = [];
  Timer? _timer;
  Future<String>? _nativeVersion;

  void record(contract.RuntimeMetricItemDtoKindEnum kind,
      contract.RuntimeMetricItemDtoOutcomeEnum outcome) {
    final current = manifest();
    final token = current?.runtimeTelemetryToken;
    if (!enabled || current == null || token == null) return;
    final context = (releaseId: current.releaseId, token: token);
    final metrics = _pending.putIfAbsent(context, () => {});
    final key = (kind, outcome);
    metrics[key] = (metrics[key] ?? 0) + 1;
    _schedule();
  }

  Future<void> flush() async {
    _timer?.cancel();
    _timer = null;
    final batches = [..._retries];
    _retries.clear();
    for (final context in [..._pending.keys]) {
      final batch = _takeBatch(context);
      if (batch != null) batches.add(batch);
    }
    for (final batch in batches) {
      try {
        await api.reportRuntimeMetrics(
          requestId: batch.requestId,
          telemetryToken: batch.context.token,
          appVersion: await _appVersion(),
          metrics: batch.metrics,
        );
      } on Object {
        if (batch.attempts < 3) {
          _retries.add(_RuntimeMetricBatch(batch.requestId, batch.context,
              batch.metrics, batch.attempts + 1));
        }
      }
    }
    if (_pending.isNotEmpty || _retries.isNotEmpty) _schedule();
  }

  void dispose() => _timer?.cancel();

  _RuntimeMetricBatch? _takeBatch(_TelemetryContext context) {
    final values = _pending[context];
    if (values == null) return null;
    var remaining = 20000;
    final metrics = <contract.RuntimeMetricItemDto>[];
    for (final entry in [...values.entries]) {
      if (metrics.length == 16 || remaining == 0) break;
      final included = min(entry.value, min(10000, remaining));
      metrics.add(contract.RuntimeMetricItemDto(
          kind: entry.key.$1, outcome: entry.key.$2, count: included));
      final leftover = entry.value - included;
      if (leftover == 0) {
        values.remove(entry.key);
      } else {
        values[entry.key] = leftover;
      }
      remaining -= included;
    }
    if (values.isEmpty) _pending.remove(context);
    return metrics.isEmpty
        ? null
        : _RuntimeMetricBatch(_requestId(), context, metrics);
  }

  void _schedule() =>
      _timer ??= Timer(const Duration(seconds: 5), () => unawaited(flush()));

  Future<String> _appVersion() async {
    if (config.appVersion.isNotEmpty) return config.appVersion;
    return _nativeVersion ??= _readNativeVersion();
  }

  Future<String> _readNativeVersion() async {
    try {
      final channel = MethodChannel(defaultTargetPlatform == TargetPlatform.iOS
          ? 'dev.linguaflow/app_attest'
          : 'dev.linguaflow/play_integrity');
      final value =
          await channel.invokeMapMethod<String, dynamic>('appVersion');
      final name = value?['name']?.toString() ?? '';
      final code = value?['code']?.toString() ?? '';
      return name.isNotEmpty && code.isNotEmpty ? '$name ($code)' : name + code;
    } on Object {
      return '';
    }
  }
}

String _requestId() {
  final secureRandom = Random.secure();
  final bytes = List<int>.generate(16, (_) => secureRandom.nextInt(256));
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  bytes[8] = (bytes[8] & 0x3f) | 0x80;
  final hex =
      bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
}
