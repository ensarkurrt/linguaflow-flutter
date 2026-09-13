//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MissingKeyReportResponseDto {
  /// Returns a new [MissingKeyReportResponseDto] instance.
  MissingKeyReportResponseDto({
    required this.accepted,
    this.reason,
    this.duplicate,
    required this.recordedKeyCount,
  });

  bool accepted;

  MissingKeyReportResponseDtoReasonEnum? reason;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? duplicate;

  /// Minimum value: 0
  int recordedKeyCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissingKeyReportResponseDto &&
          other.accepted == accepted &&
          other.reason == reason &&
          other.duplicate == duplicate &&
          other.recordedKeyCount == recordedKeyCount;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (accepted.hashCode) +
      (reason == null ? 0 : reason!.hashCode) +
      (duplicate == null ? 0 : duplicate!.hashCode) +
      (recordedKeyCount.hashCode);

  @override
  String toString() =>
      'MissingKeyReportResponseDto[accepted=$accepted, reason=$reason, duplicate=$duplicate, recordedKeyCount=$recordedKeyCount]';

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
    json[r'recordedKeyCount'] = this.recordedKeyCount;
    return json;
  }

  /// Returns a new [MissingKeyReportResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MissingKeyReportResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accepted'),
            'Required key "MissingKeyReportResponseDto[accepted]" is missing from JSON.');
        assert(json[r'accepted'] != null,
            'Required key "MissingKeyReportResponseDto[accepted]" has a null value in JSON.');
        assert(json.containsKey(r'recordedKeyCount'),
            'Required key "MissingKeyReportResponseDto[recordedKeyCount]" is missing from JSON.');
        assert(json[r'recordedKeyCount'] != null,
            'Required key "MissingKeyReportResponseDto[recordedKeyCount]" has a null value in JSON.');
        return true;
      }());

      return MissingKeyReportResponseDto(
        accepted: mapValueOfType<bool>(json, r'accepted')!,
        reason: MissingKeyReportResponseDtoReasonEnum.fromJson(json[r'reason']),
        duplicate: mapValueOfType<bool>(json, r'duplicate'),
        recordedKeyCount: mapValueOfType<int>(json, r'recordedKeyCount')!,
      );
    }
    return null;
  }

  static List<MissingKeyReportResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MissingKeyReportResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MissingKeyReportResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MissingKeyReportResponseDto> mapFromJson(dynamic json) {
    final map = <String, MissingKeyReportResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MissingKeyReportResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MissingKeyReportResponseDto-objects as value to a dart map
  static Map<String, List<MissingKeyReportResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MissingKeyReportResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MissingKeyReportResponseDto.listFromJson(
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
    'recordedKeyCount',
  };
}

enum MissingKeyReportResponseDtoReasonEnum {
  disabled._(r'disabled'),
  ;

  /// Instantiate a new enum with the provided value.
  const MissingKeyReportResponseDtoReasonEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MissingKeyReportResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MissingKeyReportResponseDtoReasonEnum? fromJson(dynamic value) =>
      MissingKeyReportResponseDtoReasonEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MissingKeyReportResponseDtoReasonEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MissingKeyReportResponseDtoReasonEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MissingKeyReportResponseDtoReasonEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MissingKeyReportResponseDtoReasonEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MissingKeyReportResponseDtoReasonEnum] to String,
/// and [decode] dynamic data back to [MissingKeyReportResponseDtoReasonEnum].
class MissingKeyReportResponseDtoReasonEnumTypeTransformer {
  factory MissingKeyReportResponseDtoReasonEnumTypeTransformer() =>
      _instance ??=
          const MissingKeyReportResponseDtoReasonEnumTypeTransformer._();

  const MissingKeyReportResponseDtoReasonEnumTypeTransformer._();

  String encode(MissingKeyReportResponseDtoReasonEnum data) => data._value;

  /// Returns the instance of [MissingKeyReportResponseDtoReasonEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MissingKeyReportResponseDtoReasonEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is MissingKeyReportResponseDtoReasonEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'disabled':
          return MissingKeyReportResponseDtoReasonEnum.disabled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MissingKeyReportResponseDtoReasonEnumTypeTransformer? _instance;
}
