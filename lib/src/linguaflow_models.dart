import 'generated/runtime_contract/api.dart' as wire;

const int linguaFlowRuntimeContractVersion = 1;
const String linguaFlowFlutterSdkVersion = '0.1.0';

class LinguaFlowException implements Exception {
  LinguaFlowException(this.message, this.statusCode);

  final String message;
  final int? statusCode;

  @override
  String toString() => 'LinguaFlowException($statusCode): $message';
}

class LfKey {
  const LfKey(this.path);

  final String path;
  Map<String, Object> get arguments => const {};
}

class LfMessage extends LfKey {
  LfMessage(super.path, this._arguments);

  final Map<String, Object> _arguments;

  @override
  Map<String, Object> get arguments => _arguments;
}

enum LocaleResolutionReason {
  selected,
  mapped,
  device,
  fallback;

  static LocaleResolutionReason parse(Object? value) => switch (value) {
        'selected' => selected,
        'mapped' => mapped,
        'device' => device,
        'fallback' || null => fallback,
        _ =>
          throw LinguaFlowException('Invalid locale resolution reason', null),
      };
}

class LocaleManifest {
  const LocaleManifest({
    required this.version,
    required this.releaseId,
    required this.sequence,
    required this.requestedLocale,
    required this.resolvedLocale,
    required this.supportedLocales,
    required this.translatedLocales,
    required this.fallbackLocale,
    required this.localeMappings,
    required this.reason,
    required this.bundlePath,
    required this.overlays,
    required this.overlay,
    required this.missingKeyTelemetryEnabled,
    required this.missingKeyTelemetryMaxBatchSize,
    required this.rolloutCandidateReleaseId,
    required this.rolloutPercentage,
    required this.rolloutSelection,
  });

  factory LocaleManifest.fromJson(Map<String, dynamic> json) {
    final missing = wire.DeliveryManifestResponseDto.requiredKeys
        .where((key) => !json.containsKey(key));
    if (missing.isNotEmpty) {
      throw LinguaFlowException(
          'Invalid locale manifest; missing ${missing.join(', ')}', null);
    }
    final contract = wire.DeliveryManifestResponseDto.fromJson(json);
    if (contract == null ||
        contract.version.toJson() != linguaFlowRuntimeContractVersion) {
      throw LinguaFlowException(
          'Unsupported LinguaFlow contract version: ${json['version']}', null);
    }
    return LocaleManifest(
      version: contract.version.toJson(),
      releaseId: contract.releaseId,
      sequence: contract.sequence,
      requestedLocale: contract.requestedLocale,
      resolvedLocale: contract.resolvedLocale,
      supportedLocales: contract.supportedLocales,
      translatedLocales: contract.translatedLocales,
      fallbackLocale: contract.fallbackLocale,
      localeMappings: {
        for (final entry in contract.localeMappings.entries)
          normalizeLocale(entry.key): entry.value,
      },
      reason: LocaleResolutionReason.parse(contract.reason.toJson()),
      bundlePath: contract.bundlePath,
      overlays: contract.overlays,
      overlay: contract.overlay,
      missingKeyTelemetryEnabled: contract.missingKeyTelemetry.enabled,
      missingKeyTelemetryMaxBatchSize:
          contract.missingKeyTelemetry.maxBatchSize,
      rolloutCandidateReleaseId: contract.rollout.candidateReleaseId,
      rolloutPercentage: contract.rollout.percentage,
      rolloutSelection: contract.rollout.selection.toJson(),
    );
  }

  final String releaseId;
  final int version;
  final int sequence;
  final String requestedLocale;
  final String resolvedLocale;
  final List<String> supportedLocales;
  final List<String> translatedLocales;
  final String fallbackLocale;
  final Map<String, String> localeMappings;
  final LocaleResolutionReason reason;
  final String bundlePath;
  final List<String> overlays;
  final String? overlay;
  final bool missingKeyTelemetryEnabled;
  final int missingKeyTelemetryMaxBatchSize;
  final String rolloutCandidateReleaseId;
  final int rolloutPercentage;
  final String rolloutSelection;

  LocaleManifest withResolution(LocaleResolution resolution) => LocaleManifest(
        version: version,
        releaseId: releaseId,
        sequence: sequence,
        requestedLocale: resolution.requestedLocale,
        resolvedLocale: resolution.resolvedLocale,
        supportedLocales: supportedLocales,
        translatedLocales: translatedLocales,
        fallbackLocale: fallbackLocale,
        localeMappings: localeMappings,
        reason: resolution.reason,
        bundlePath: bundlePath,
        overlays: overlays,
        overlay: overlay,
        missingKeyTelemetryEnabled: missingKeyTelemetryEnabled,
        missingKeyTelemetryMaxBatchSize: missingKeyTelemetryMaxBatchSize,
        rolloutCandidateReleaseId: rolloutCandidateReleaseId,
        rolloutPercentage: rolloutPercentage,
        rolloutSelection: rolloutSelection,
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'releaseId': releaseId,
        'sequence': sequence,
        'requestedLocale': requestedLocale,
        'resolvedLocale': resolvedLocale,
        'supportedLocales': supportedLocales,
        'translatedLocales': translatedLocales,
        'fallbackLocale': fallbackLocale,
        'localeMappings': localeMappings,
        'reason': reason.name,
        'bundlePath': bundlePath,
        'overlays': overlays,
        'overlay': overlay,
        'missingKeyTelemetry': {
          'enabled': missingKeyTelemetryEnabled,
          'maxBatchSize': missingKeyTelemetryMaxBatchSize,
        },
        'rollout': {
          'candidateReleaseId': rolloutCandidateReleaseId,
          'percentage': rolloutPercentage,
          'selection': rolloutSelection,
        },
      };
}

typedef LocaleResolution = ({
  String requestedLocale,
  String resolvedLocale,
  LocaleResolutionReason reason,
});

String normalizeLocale(String locale) =>
    locale.trim().replaceAll('_', '-').toLowerCase();
