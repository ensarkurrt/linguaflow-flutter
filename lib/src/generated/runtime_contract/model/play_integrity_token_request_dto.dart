//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PlayIntegrityTokenRequestDto {
  /// Returns a new [PlayIntegrityTokenRequestDto] instance.
  PlayIntegrityTokenRequestDto({
    required this.packageName,
    required this.challengeId,
    required this.integrityToken,
  });

  String packageName;

  String challengeId;

  String integrityToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayIntegrityTokenRequestDto &&
          other.packageName == packageName &&
          other.challengeId == challengeId &&
          other.integrityToken == integrityToken;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (packageName.hashCode) +
      (challengeId.hashCode) +
      (integrityToken.hashCode);

  @override
  String toString() =>
      'PlayIntegrityTokenRequestDto[packageName=$packageName, challengeId=$challengeId, integrityToken=$integrityToken]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'packageName'] = this.packageName;
    json[r'challengeId'] = this.challengeId;
    json[r'integrityToken'] = this.integrityToken;
    return json;
  }

  /// Returns a new [PlayIntegrityTokenRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PlayIntegrityTokenRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'packageName'),
            'Required key "PlayIntegrityTokenRequestDto[packageName]" is missing from JSON.');
        assert(json[r'packageName'] != null,
            'Required key "PlayIntegrityTokenRequestDto[packageName]" has a null value in JSON.');
        assert(json.containsKey(r'challengeId'),
            'Required key "PlayIntegrityTokenRequestDto[challengeId]" is missing from JSON.');
        assert(json[r'challengeId'] != null,
            'Required key "PlayIntegrityTokenRequestDto[challengeId]" has a null value in JSON.');
        assert(json.containsKey(r'integrityToken'),
            'Required key "PlayIntegrityTokenRequestDto[integrityToken]" is missing from JSON.');
        assert(json[r'integrityToken'] != null,
            'Required key "PlayIntegrityTokenRequestDto[integrityToken]" has a null value in JSON.');
        return true;
      }());

      return PlayIntegrityTokenRequestDto(
        packageName: mapValueOfType<String>(json, r'packageName')!,
        challengeId: mapValueOfType<String>(json, r'challengeId')!,
        integrityToken: mapValueOfType<String>(json, r'integrityToken')!,
      );
    }
    return null;
  }

  static List<PlayIntegrityTokenRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PlayIntegrityTokenRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PlayIntegrityTokenRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PlayIntegrityTokenRequestDto> mapFromJson(dynamic json) {
    final map = <String, PlayIntegrityTokenRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PlayIntegrityTokenRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PlayIntegrityTokenRequestDto-objects as value to a dart map
  static Map<String, List<PlayIntegrityTokenRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PlayIntegrityTokenRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PlayIntegrityTokenRequestDto.listFromJson(
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
    'challengeId',
    'integrityToken',
  };
}
