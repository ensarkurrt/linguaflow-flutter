//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeliveryManifestResponseDto {
  /// Returns a new [DeliveryManifestResponseDto] instance.
  DeliveryManifestResponseDto({
    required this.version,
    required this.releaseId,
    required this.sequence,
    required this.requestedLocale,
    required this.resolvedLocale,
    required this.reason,
    required this.fallbackLocale,
    this.supportedLocales = const [],
    this.translatedLocales = const [],
    this.localeMappings = const {},
    required this.rollout,
    required this.bundlePath,
    this.overlays = const [],
    required this.overlay,
    required this.missingKeyTelemetry,
    required this.runtimeTelemetry,
  });

  DeliveryManifestResponseDtoVersionEnum version;

  String releaseId;

  /// Minimum value: 1
  int sequence;

  String requestedLocale;

  String resolvedLocale;

  DeliveryManifestResponseDtoReasonEnum reason;

  String fallbackLocale;

  List<String> supportedLocales;

  List<String> translatedLocales;

  Map<String, String> localeMappings;

  DeliveryRolloutResponseDto rollout;

  String bundlePath;

  List<String> overlays;

  String? overlay;

  MissingKeyTelemetryPolicyResponseDto missingKeyTelemetry;

  DeliveryRuntimeTelemetryResponseDto? runtimeTelemetry;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryManifestResponseDto &&
          other.version == version &&
          other.releaseId == releaseId &&
          other.sequence == sequence &&
          other.requestedLocale == requestedLocale &&
          other.resolvedLocale == resolvedLocale &&
          other.reason == reason &&
          other.fallbackLocale == fallbackLocale &&
          _deepEquality.equals(other.supportedLocales, supportedLocales) &&
          _deepEquality.equals(other.translatedLocales, translatedLocales) &&
          _deepEquality.equals(other.localeMappings, localeMappings) &&
          other.rollout == rollout &&
          other.bundlePath == bundlePath &&
          _deepEquality.equals(other.overlays, overlays) &&
          other.overlay == overlay &&
          other.missingKeyTelemetry == missingKeyTelemetry &&
          other.runtimeTelemetry == runtimeTelemetry;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (version.hashCode) +
      (releaseId.hashCode) +
      (sequence.hashCode) +
      (requestedLocale.hashCode) +
      (resolvedLocale.hashCode) +
      (reason.hashCode) +
      (fallbackLocale.hashCode) +
      (supportedLocales.hashCode) +
      (translatedLocales.hashCode) +
      (localeMappings.hashCode) +
      (rollout.hashCode) +
      (bundlePath.hashCode) +
      (overlays.hashCode) +
      (overlay == null ? 0 : overlay!.hashCode) +
      (missingKeyTelemetry.hashCode) +
      (runtimeTelemetry == null ? 0 : runtimeTelemetry!.hashCode);

  @override
  String toString() =>
      'DeliveryManifestResponseDto[version=$version, releaseId=$releaseId, sequence=$sequence, requestedLocale=$requestedLocale, resolvedLocale=$resolvedLocale, reason=$reason, fallbackLocale=$fallbackLocale, supportedLocales=$supportedLocales, translatedLocales=$translatedLocales, localeMappings=$localeMappings, rollout=$rollout, bundlePath=$bundlePath, overlays=$overlays, overlay=$overlay, missingKeyTelemetry=$missingKeyTelemetry, runtimeTelemetry=$runtimeTelemetry]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'version'] = this.version;
    json[r'releaseId'] = this.releaseId;
    json[r'sequence'] = this.sequence;
    json[r'requestedLocale'] = this.requestedLocale;
    json[r'resolvedLocale'] = this.resolvedLocale;
    json[r'reason'] = this.reason;
    json[r'fallbackLocale'] = this.fallbackLocale;
    json[r'supportedLocales'] = this.supportedLocales;
    json[r'translatedLocales'] = this.translatedLocales;
    json[r'localeMappings'] = this.localeMappings;
    json[r'rollout'] = this.rollout;
    json[r'bundlePath'] = this.bundlePath;
    json[r'overlays'] = this.overlays;
    if (this.overlay != null) {
      json[r'overlay'] = this.overlay;
    } else {
      json[r'overlay'] = null;
    }
    json[r'missingKeyTelemetry'] = this.missingKeyTelemetry;
    if (this.runtimeTelemetry != null) {
      json[r'runtimeTelemetry'] = this.runtimeTelemetry;
    } else {
      json[r'runtimeTelemetry'] = null;
    }
    return json;
  }

  /// Returns a new [DeliveryManifestResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeliveryManifestResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'version'),
            'Required key "DeliveryManifestResponseDto[version]" is missing from JSON.');
        assert(json[r'version'] != null,
            'Required key "DeliveryManifestResponseDto[version]" has a null value in JSON.');
        assert(json.containsKey(r'releaseId'),
            'Required key "DeliveryManifestResponseDto[releaseId]" is missing from JSON.');
        assert(json[r'releaseId'] != null,
            'Required key "DeliveryManifestResponseDto[releaseId]" has a null value in JSON.');
        assert(json.containsKey(r'sequence'),
            'Required key "DeliveryManifestResponseDto[sequence]" is missing from JSON.');
        assert(json[r'sequence'] != null,
            'Required key "DeliveryManifestResponseDto[sequence]" has a null value in JSON.');
        assert(json.containsKey(r'requestedLocale'),
            'Required key "DeliveryManifestResponseDto[requestedLocale]" is missing from JSON.');
        assert(json[r'requestedLocale'] != null,
            'Required key "DeliveryManifestResponseDto[requestedLocale]" has a null value in JSON.');
        assert(json.containsKey(r'resolvedLocale'),
            'Required key "DeliveryManifestResponseDto[resolvedLocale]" is missing from JSON.');
        assert(json[r'resolvedLocale'] != null,
            'Required key "DeliveryManifestResponseDto[resolvedLocale]" has a null value in JSON.');
        assert(json.containsKey(r'reason'),
            'Required key "DeliveryManifestResponseDto[reason]" is missing from JSON.');
        assert(json[r'reason'] != null,
            'Required key "DeliveryManifestResponseDto[reason]" has a null value in JSON.');
        assert(json.containsKey(r'fallbackLocale'),
            'Required key "DeliveryManifestResponseDto[fallbackLocale]" is missing from JSON.');
        assert(json[r'fallbackLocale'] != null,
            'Required key "DeliveryManifestResponseDto[fallbackLocale]" has a null value in JSON.');
        assert(json.containsKey(r'supportedLocales'),
            'Required key "DeliveryManifestResponseDto[supportedLocales]" is missing from JSON.');
        assert(json[r'supportedLocales'] != null,
            'Required key "DeliveryManifestResponseDto[supportedLocales]" has a null value in JSON.');
        assert(json.containsKey(r'translatedLocales'),
            'Required key "DeliveryManifestResponseDto[translatedLocales]" is missing from JSON.');
        assert(json[r'translatedLocales'] != null,
            'Required key "DeliveryManifestResponseDto[translatedLocales]" has a null value in JSON.');
        assert(json.containsKey(r'localeMappings'),
            'Required key "DeliveryManifestResponseDto[localeMappings]" is missing from JSON.');
        assert(json[r'localeMappings'] != null,
            'Required key "DeliveryManifestResponseDto[localeMappings]" has a null value in JSON.');
        assert(json.containsKey(r'rollout'),
            'Required key "DeliveryManifestResponseDto[rollout]" is missing from JSON.');
        assert(json[r'rollout'] != null,
            'Required key "DeliveryManifestResponseDto[rollout]" has a null value in JSON.');
        assert(json.containsKey(r'bundlePath'),
            'Required key "DeliveryManifestResponseDto[bundlePath]" is missing from JSON.');
        assert(json[r'bundlePath'] != null,
            'Required key "DeliveryManifestResponseDto[bundlePath]" has a null value in JSON.');
        assert(json.containsKey(r'overlays'),
            'Required key "DeliveryManifestResponseDto[overlays]" is missing from JSON.');
        assert(json[r'overlays'] != null,
            'Required key "DeliveryManifestResponseDto[overlays]" has a null value in JSON.');
        assert(json.containsKey(r'overlay'),
            'Required key "DeliveryManifestResponseDto[overlay]" is missing from JSON.');
        assert(json.containsKey(r'missingKeyTelemetry'),
            'Required key "DeliveryManifestResponseDto[missingKeyTelemetry]" is missing from JSON.');
        assert(json[r'missingKeyTelemetry'] != null,
            'Required key "DeliveryManifestResponseDto[missingKeyTelemetry]" has a null value in JSON.');
        assert(json.containsKey(r'runtimeTelemetry'),
            'Required key "DeliveryManifestResponseDto[runtimeTelemetry]" is missing from JSON.');
        return true;
      }());

      return DeliveryManifestResponseDto(
        version:
            DeliveryManifestResponseDtoVersionEnum.fromJson(json[r'version'])!,
        releaseId: mapValueOfType<String>(json, r'releaseId')!,
        sequence: mapValueOfType<int>(json, r'sequence')!,
        requestedLocale: mapValueOfType<String>(json, r'requestedLocale')!,
        resolvedLocale: mapValueOfType<String>(json, r'resolvedLocale')!,
        reason:
            DeliveryManifestResponseDtoReasonEnum.fromJson(json[r'reason'])!,
        fallbackLocale: mapValueOfType<String>(json, r'fallbackLocale')!,
        supportedLocales: json[r'supportedLocales'] is Iterable
            ? (json[r'supportedLocales'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        translatedLocales: json[r'translatedLocales'] is Iterable
            ? (json[r'translatedLocales'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        localeMappings: mapCastOfType<String, String>(json, r'localeMappings')!,
        rollout: DeliveryRolloutResponseDto.fromJson(json[r'rollout'])!,
        bundlePath: mapValueOfType<String>(json, r'bundlePath')!,
        overlays: json[r'overlays'] is Iterable
            ? (json[r'overlays'] as Iterable)
                .cast<String>()
                .toList(growable: false)
            : const [],
        overlay: mapValueOfType<String>(json, r'overlay'),
        missingKeyTelemetry: MissingKeyTelemetryPolicyResponseDto.fromJson(
            json[r'missingKeyTelemetry'])!,
        runtimeTelemetry: DeliveryRuntimeTelemetryResponseDto.fromJson(
            json[r'runtimeTelemetry']),
      );
    }
    return null;
  }

  static List<DeliveryManifestResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DeliveryManifestResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeliveryManifestResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeliveryManifestResponseDto> mapFromJson(dynamic json) {
    final map = <String, DeliveryManifestResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeliveryManifestResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeliveryManifestResponseDto-objects as value to a dart map
  static Map<String, List<DeliveryManifestResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DeliveryManifestResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeliveryManifestResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'version',
    'releaseId',
    'sequence',
    'requestedLocale',
    'resolvedLocale',
    'reason',
    'fallbackLocale',
    'supportedLocales',
    'translatedLocales',
    'localeMappings',
    'rollout',
    'bundlePath',
    'overlays',
    'overlay',
    'missingKeyTelemetry',
    'runtimeTelemetry',
  };
}

enum DeliveryManifestResponseDtoVersionEnum {
  number2._(2),
  ;

  /// Instantiate a new enum with the provided value.
  const DeliveryManifestResponseDtoVersionEnum._(this._value);

  /// The underlying value of this enum member.
  final int _value;

  @override
  String toString() => _value.toString();

  /// Encodes this enum as a value suitable for JSON.
  int toJson() => _value;

  /// Returns the instance of [DeliveryManifestResponseDtoVersionEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DeliveryManifestResponseDtoVersionEnum? fromJson(dynamic value) =>
      DeliveryManifestResponseDtoVersionEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DeliveryManifestResponseDtoVersionEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DeliveryManifestResponseDtoVersionEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DeliveryManifestResponseDtoVersionEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeliveryManifestResponseDtoVersionEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeliveryManifestResponseDtoVersionEnum] to int,
/// and [decode] dynamic data back to [DeliveryManifestResponseDtoVersionEnum].
class DeliveryManifestResponseDtoVersionEnumTypeTransformer {
  factory DeliveryManifestResponseDtoVersionEnumTypeTransformer() =>
      _instance ??=
          const DeliveryManifestResponseDtoVersionEnumTypeTransformer._();

  const DeliveryManifestResponseDtoVersionEnumTypeTransformer._();

  int encode(DeliveryManifestResponseDtoVersionEnum data) => data._value;

  /// Returns the instance of [DeliveryManifestResponseDtoVersionEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeliveryManifestResponseDtoVersionEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is DeliveryManifestResponseDtoVersionEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case 2:
          return DeliveryManifestResponseDtoVersionEnum.number2;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DeliveryManifestResponseDtoVersionEnumTypeTransformer? _instance;
}

enum DeliveryManifestResponseDtoReasonEnum {
  selected._(r'selected'),
  mapped._(r'mapped'),
  device._(r'device'),
  fallback._(r'fallback'),
  ;

  /// Instantiate a new enum with the provided value.
  const DeliveryManifestResponseDtoReasonEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DeliveryManifestResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DeliveryManifestResponseDtoReasonEnum? fromJson(dynamic value) =>
      DeliveryManifestResponseDtoReasonEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DeliveryManifestResponseDtoReasonEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DeliveryManifestResponseDtoReasonEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DeliveryManifestResponseDtoReasonEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeliveryManifestResponseDtoReasonEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeliveryManifestResponseDtoReasonEnum] to String,
/// and [decode] dynamic data back to [DeliveryManifestResponseDtoReasonEnum].
class DeliveryManifestResponseDtoReasonEnumTypeTransformer {
  factory DeliveryManifestResponseDtoReasonEnumTypeTransformer() =>
      _instance ??=
          const DeliveryManifestResponseDtoReasonEnumTypeTransformer._();

  const DeliveryManifestResponseDtoReasonEnumTypeTransformer._();

  String encode(DeliveryManifestResponseDtoReasonEnum data) => data._value;

  /// Returns the instance of [DeliveryManifestResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeliveryManifestResponseDtoReasonEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is DeliveryManifestResponseDtoReasonEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'selected':
          return DeliveryManifestResponseDtoReasonEnum.selected;
        case r'mapped':
          return DeliveryManifestResponseDtoReasonEnum.mapped;
        case r'device':
          return DeliveryManifestResponseDtoReasonEnum.device;
        case r'fallback':
          return DeliveryManifestResponseDtoReasonEnum.fallback;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DeliveryManifestResponseDtoReasonEnumTypeTransformer? _instance;
}
