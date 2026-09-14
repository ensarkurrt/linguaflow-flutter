//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RuntimeMetricReportRequestDto {
  /// Returns a new [RuntimeMetricReportRequestDto] instance.
  RuntimeMetricReportRequestDto({
    required this.requestId,
    required this.appVersion,
    this.metrics = const [],
  });

  String requestId;

  String appVersion;

  List<RuntimeMetricItemDto> metrics;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RuntimeMetricReportRequestDto &&
          other.requestId == requestId &&
          other.appVersion == appVersion &&
          _deepEquality.equals(other.metrics, metrics);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (requestId.hashCode) + (appVersion.hashCode) + (metrics.hashCode);

  @override
  String toString() =>
      'RuntimeMetricReportRequestDto[requestId=$requestId, appVersion=$appVersion, metrics=$metrics]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'requestId'] = this.requestId;
    json[r'appVersion'] = this.appVersion;
    json[r'metrics'] = this.metrics;
    return json;
  }

  /// Returns a new [RuntimeMetricReportRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RuntimeMetricReportRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'requestId'),
            'Required key "RuntimeMetricReportRequestDto[requestId]" is missing from JSON.');
        assert(json[r'requestId'] != null,
            'Required key "RuntimeMetricReportRequestDto[requestId]" has a null value in JSON.');
        assert(json.containsKey(r'appVersion'),
            'Required key "RuntimeMetricReportRequestDto[appVersion]" is missing from JSON.');
        assert(json[r'appVersion'] != null,
            'Required key "RuntimeMetricReportRequestDto[appVersion]" has a null value in JSON.');
        assert(json.containsKey(r'metrics'),
            'Required key "RuntimeMetricReportRequestDto[metrics]" is missing from JSON.');
        assert(json[r'metrics'] != null,
            'Required key "RuntimeMetricReportRequestDto[metrics]" has a null value in JSON.');
        return true;
      }());

      return RuntimeMetricReportRequestDto(
        requestId: mapValueOfType<String>(json, r'requestId')!,
        appVersion: mapValueOfType<String>(json, r'appVersion')!,
        metrics: RuntimeMetricItemDto.listFromJson(json[r'metrics']),
      );
    }
    return null;
  }

  static List<RuntimeMetricReportRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RuntimeMetricReportRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RuntimeMetricReportRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RuntimeMetricReportRequestDto> mapFromJson(dynamic json) {
    final map = <String, RuntimeMetricReportRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RuntimeMetricReportRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RuntimeMetricReportRequestDto-objects as value to a dart map
  static Map<String, List<RuntimeMetricReportRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RuntimeMetricReportRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RuntimeMetricReportRequestDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'requestId',
    'appVersion',
    'metrics',
  };
}
