//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RuntimeMetricItemDto {
  /// Returns a new [RuntimeMetricItemDto] instance.
  RuntimeMetricItemDto({
    required this.kind,
    required this.outcome,
    required this.count,
  });

  RuntimeMetricItemDtoKindEnum kind;

  RuntimeMetricItemDtoOutcomeEnum outcome;

  /// Minimum value: 1
  /// Maximum value: 10000
  int count;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuntimeMetricItemDto &&
          other.kind == kind &&
          other.outcome == outcome &&
          other.count == count;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (kind.hashCode) + (outcome.hashCode) + (count.hashCode);

  @override
  String toString() =>
      'RuntimeMetricItemDto[kind=$kind, outcome=$outcome, count=$count]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'kind'] = this.kind;
    json[r'outcome'] = this.outcome;
    json[r'count'] = this.count;
    return json;
  }

  /// Returns a new [RuntimeMetricItemDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RuntimeMetricItemDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'kind'),
            'Required key "RuntimeMetricItemDto[kind]" is missing from JSON.');
        assert(json[r'kind'] != null,
            'Required key "RuntimeMetricItemDto[kind]" has a null value in JSON.');
        assert(json.containsKey(r'outcome'),
            'Required key "RuntimeMetricItemDto[outcome]" is missing from JSON.');
        assert(json[r'outcome'] != null,
            'Required key "RuntimeMetricItemDto[outcome]" has a null value in JSON.');
        assert(json.containsKey(r'count'),
            'Required key "RuntimeMetricItemDto[count]" is missing from JSON.');
        assert(json[r'count'] != null,
            'Required key "RuntimeMetricItemDto[count]" has a null value in JSON.');
        return true;
      }());

      return RuntimeMetricItemDto(
        kind: RuntimeMetricItemDtoKindEnum.fromJson(json[r'kind'])!,
        outcome: RuntimeMetricItemDtoOutcomeEnum.fromJson(json[r'outcome'])!,
        count: mapValueOfType<int>(json, r'count')!,
      );
    }
    return null;
  }

  static List<RuntimeMetricItemDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricItemDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricItemDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RuntimeMetricItemDto> mapFromJson(dynamic json) {
    final map = <String, RuntimeMetricItemDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RuntimeMetricItemDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RuntimeMetricItemDto-objects as value to a dart map
  static Map<String, List<RuntimeMetricItemDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RuntimeMetricItemDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RuntimeMetricItemDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'kind',
    'outcome',
    'count',
  };
}

enum RuntimeMetricItemDtoKindEnum {
  bundleDownload._(r'bundle_download'),
  bundleParse._(r'bundle_parse'),
  icuFormat._(r'icu_format'),
  deliveryRequest._(r'delivery_request'),
  ;

  /// Instantiate a new enum with the provided value.
  const RuntimeMetricItemDtoKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [RuntimeMetricItemDtoKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static RuntimeMetricItemDtoKindEnum? fromJson(dynamic value) =>
      RuntimeMetricItemDtoKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [RuntimeMetricItemDtoKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<RuntimeMetricItemDtoKindEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricItemDtoKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricItemDtoKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RuntimeMetricItemDtoKindEnum] to String,
/// and [decode] dynamic data back to [RuntimeMetricItemDtoKindEnum].
class RuntimeMetricItemDtoKindEnumTypeTransformer {
  factory RuntimeMetricItemDtoKindEnumTypeTransformer() =>
      _instance ??= const RuntimeMetricItemDtoKindEnumTypeTransformer._();

  const RuntimeMetricItemDtoKindEnumTypeTransformer._();

  String encode(RuntimeMetricItemDtoKindEnum data) => data._value;

  /// Returns the instance of [RuntimeMetricItemDtoKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RuntimeMetricItemDtoKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is RuntimeMetricItemDtoKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'bundle_download':
          return RuntimeMetricItemDtoKindEnum.bundleDownload;
        case r'bundle_parse':
          return RuntimeMetricItemDtoKindEnum.bundleParse;
        case r'icu_format':
          return RuntimeMetricItemDtoKindEnum.icuFormat;
        case r'delivery_request':
          return RuntimeMetricItemDtoKindEnum.deliveryRequest;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static RuntimeMetricItemDtoKindEnumTypeTransformer? _instance;
}

enum RuntimeMetricItemDtoOutcomeEnum {
  success._(r'success'),
  failure._(r'failure'),
  timeout._(r'timeout'),
  serverError._(r'server_error'),
  ;

  /// Instantiate a new enum with the provided value.
  const RuntimeMetricItemDtoOutcomeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [RuntimeMetricItemDtoOutcomeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static RuntimeMetricItemDtoOutcomeEnum? fromJson(dynamic value) =>
      RuntimeMetricItemDtoOutcomeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [RuntimeMetricItemDtoOutcomeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<RuntimeMetricItemDtoOutcomeEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricItemDtoOutcomeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricItemDtoOutcomeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RuntimeMetricItemDtoOutcomeEnum] to String,
/// and [decode] dynamic data back to [RuntimeMetricItemDtoOutcomeEnum].
class RuntimeMetricItemDtoOutcomeEnumTypeTransformer {
  factory RuntimeMetricItemDtoOutcomeEnumTypeTransformer() =>
      _instance ??= const RuntimeMetricItemDtoOutcomeEnumTypeTransformer._();

  const RuntimeMetricItemDtoOutcomeEnumTypeTransformer._();

  String encode(RuntimeMetricItemDtoOutcomeEnum data) => data._value;

  /// Returns the instance of [RuntimeMetricItemDtoOutcomeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RuntimeMetricItemDtoOutcomeEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is RuntimeMetricItemDtoOutcomeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'success':
          return RuntimeMetricItemDtoOutcomeEnum.success;
        case r'failure':
          return RuntimeMetricItemDtoOutcomeEnum.failure;
        case r'timeout':
          return RuntimeMetricItemDtoOutcomeEnum.timeout;
        case r'server_error':
          return RuntimeMetricItemDtoOutcomeEnum.serverError;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static RuntimeMetricItemDtoOutcomeEnumTypeTransformer? _instance;
}
