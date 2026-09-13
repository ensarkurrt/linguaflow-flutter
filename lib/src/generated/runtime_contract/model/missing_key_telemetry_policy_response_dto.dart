//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MissingKeyTelemetryPolicyResponseDto {
  /// Returns a new [MissingKeyTelemetryPolicyResponseDto] instance.
  MissingKeyTelemetryPolicyResponseDto({
    required this.enabled,
    required this.maxBatchSize,
  });

  bool enabled;

  /// Minimum value: 1
  int maxBatchSize;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissingKeyTelemetryPolicyResponseDto &&
          other.enabled == enabled &&
          other.maxBatchSize == maxBatchSize;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (enabled.hashCode) + (maxBatchSize.hashCode);

  @override
  String toString() =>
      'MissingKeyTelemetryPolicyResponseDto[enabled=$enabled, maxBatchSize=$maxBatchSize]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'enabled'] = this.enabled;
    json[r'maxBatchSize'] = this.maxBatchSize;
    return json;
  }

  /// Returns a new [MissingKeyTelemetryPolicyResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MissingKeyTelemetryPolicyResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'enabled'),
            'Required key "MissingKeyTelemetryPolicyResponseDto[enabled]" is missing from JSON.');
        assert(json[r'enabled'] != null,
            'Required key "MissingKeyTelemetryPolicyResponseDto[enabled]" has a null value in JSON.');
        assert(json.containsKey(r'maxBatchSize'),
            'Required key "MissingKeyTelemetryPolicyResponseDto[maxBatchSize]" is missing from JSON.');
        assert(json[r'maxBatchSize'] != null,
            'Required key "MissingKeyTelemetryPolicyResponseDto[maxBatchSize]" has a null value in JSON.');
        return true;
      }());

      return MissingKeyTelemetryPolicyResponseDto(
        enabled: mapValueOfType<bool>(json, r'enabled')!,
        maxBatchSize: mapValueOfType<int>(json, r'maxBatchSize')!,
      );
    }
    return null;
  }

  static List<MissingKeyTelemetryPolicyResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MissingKeyTelemetryPolicyResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MissingKeyTelemetryPolicyResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MissingKeyTelemetryPolicyResponseDto> mapFromJson(
      dynamic json) {
    final map = <String, MissingKeyTelemetryPolicyResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value =
            MissingKeyTelemetryPolicyResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MissingKeyTelemetryPolicyResponseDto-objects as value to a dart map
  static Map<String, List<MissingKeyTelemetryPolicyResponseDto>>
      mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MissingKeyTelemetryPolicyResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MissingKeyTelemetryPolicyResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'enabled',
    'maxBatchSize',
  };
}
