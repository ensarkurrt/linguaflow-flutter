//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PlayIntegrityChallengeRequestDto {
  /// Returns a new [PlayIntegrityChallengeRequestDto] instance.
  PlayIntegrityChallengeRequestDto({
    required this.packageName,
  });

  String packageName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayIntegrityChallengeRequestDto &&
          other.packageName == packageName;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (packageName.hashCode);

  @override
  String toString() =>
      'PlayIntegrityChallengeRequestDto[packageName=$packageName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'packageName'] = this.packageName;
    return json;
  }

  /// Returns a new [PlayIntegrityChallengeRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PlayIntegrityChallengeRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'packageName'),
            'Required key "PlayIntegrityChallengeRequestDto[packageName]" is missing from JSON.');
        assert(json[r'packageName'] != null,
            'Required key "PlayIntegrityChallengeRequestDto[packageName]" has a null value in JSON.');
        return true;
      }());

      return PlayIntegrityChallengeRequestDto(
        packageName: mapValueOfType<String>(json, r'packageName')!,
      );
    }
    return null;
  }

  static List<PlayIntegrityChallengeRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PlayIntegrityChallengeRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PlayIntegrityChallengeRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PlayIntegrityChallengeRequestDto> mapFromJson(
      dynamic json) {
    final map = <String, PlayIntegrityChallengeRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PlayIntegrityChallengeRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PlayIntegrityChallengeRequestDto-objects as value to a dart map
  static Map<String, List<PlayIntegrityChallengeRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PlayIntegrityChallengeRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PlayIntegrityChallengeRequestDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'packageName',
  };
}
