//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RuntimeMetricReportResponseDto {
  /// Returns a new [RuntimeMetricReportResponseDto] instance.
  RuntimeMetricReportResponseDto({
    required this.accepted,
    this.reason,
    this.duplicate,
  });

  bool accepted;

  RuntimeMetricReportResponseDtoReasonEnum? reason;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? duplicate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuntimeMetricReportResponseDto &&
          other.accepted == accepted &&
          other.reason == reason &&
          other.duplicate == duplicate;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (accepted.hashCode) +
      (reason == null ? 0 : reason!.hashCode) +
      (duplicate == null ? 0 : duplicate!.hashCode);

  @override
  String toString() =>
      'RuntimeMetricReportResponseDto[accepted=$accepted, reason=$reason, duplicate=$duplicate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'accepted'] = this.accepted;
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.duplicate != null) {
      json[r'duplicate'] = this.duplicate;
    } else {
      json[r'duplicate'] = null;
    }
    return json;
  }

  /// Returns a new [RuntimeMetricReportResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RuntimeMetricReportResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accepted'),
            'Required key "RuntimeMetricReportResponseDto[accepted]" is missing from JSON.');
        assert(json[r'accepted'] != null,
            'Required key "RuntimeMetricReportResponseDto[accepted]" has a null value in JSON.');
        return true;
      }());

      return RuntimeMetricReportResponseDto(
        accepted: mapValueOfType<bool>(json, r'accepted')!,
        reason:
            RuntimeMetricReportResponseDtoReasonEnum.fromJson(json[r'reason']),
        duplicate: mapValueOfType<bool>(json, r'duplicate'),
      );
    }
    return null;
  }

  static List<RuntimeMetricReportResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricReportResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricReportResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RuntimeMetricReportResponseDto> mapFromJson(dynamic json) {
    final map = <String, RuntimeMetricReportResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RuntimeMetricReportResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RuntimeMetricReportResponseDto-objects as value to a dart map
  static Map<String, List<RuntimeMetricReportResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RuntimeMetricReportResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RuntimeMetricReportResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accepted',
  };
}

enum RuntimeMetricReportResponseDtoReasonEnum {
  telemetryTicketRequired._(r'telemetry_ticket_required'),
  ;

  /// Instantiate a new enum with the provided value.
  const RuntimeMetricReportResponseDtoReasonEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [RuntimeMetricReportResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static RuntimeMetricReportResponseDtoReasonEnum? fromJson(dynamic value) =>
      RuntimeMetricReportResponseDtoReasonEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [RuntimeMetricReportResponseDtoReasonEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<RuntimeMetricReportResponseDtoReasonEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricReportResponseDtoReasonEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricReportResponseDtoReasonEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RuntimeMetricReportResponseDtoReasonEnum] to String,
/// and [decode] dynamic data back to [RuntimeMetricReportResponseDtoReasonEnum].
class RuntimeMetricReportResponseDtoReasonEnumTypeTransformer {
  factory RuntimeMetricReportResponseDtoReasonEnumTypeTransformer() =>
      _instance ??=
          const RuntimeMetricReportResponseDtoReasonEnumTypeTransformer._();

  const RuntimeMetricReportResponseDtoReasonEnumTypeTransformer._();

  String encode(RuntimeMetricReportResponseDtoReasonEnum data) => data._value;

  /// Returns the instance of [RuntimeMetricReportResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RuntimeMetricReportResponseDtoReasonEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is RuntimeMetricReportResponseDtoReasonEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'telemetry_ticket_required':
          return RuntimeMetricReportResponseDtoReasonEnum
              .telemetryTicketRequired;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static RuntimeMetricReportResponseDtoReasonEnumTypeTransformer? _instance;
}
