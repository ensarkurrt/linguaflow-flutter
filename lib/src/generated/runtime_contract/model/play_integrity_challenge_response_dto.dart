//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PlayIntegrityChallengeResponseDto {
  /// Returns a new [PlayIntegrityChallengeResponseDto] instance.
  PlayIntegrityChallengeResponseDto({
    required this.challengeId,
    required this.requestHash,
    required this.cloudProjectNumber,
    required this.expiresAt,
  });

  String challengeId;

  String requestHash;

  String cloudProjectNumber;

  DateTime expiresAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayIntegrityChallengeResponseDto &&
          other.challengeId == challengeId &&
          other.requestHash == requestHash &&
          other.cloudProjectNumber == cloudProjectNumber &&
          other.expiresAt == expiresAt;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (challengeId.hashCode) +
      (requestHash.hashCode) +
      (cloudProjectNumber.hashCode) +
      (expiresAt.hashCode);

  @override
  String toString() =>
      'PlayIntegrityChallengeResponseDto[challengeId=$challengeId, requestHash=$requestHash, cloudProjectNumber=$cloudProjectNumber, expiresAt=$expiresAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'challengeId'] = this.challengeId;
    json[r'requestHash'] = this.requestHash;
    json[r'cloudProjectNumber'] = this.cloudProjectNumber;
    json[r'expiresAt'] = this.expiresAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [PlayIntegrityChallengeResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PlayIntegrityChallengeResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'challengeId'),
            'Required key "PlayIntegrityChallengeResponseDto[challengeId]" is missing from JSON.');
        assert(json[r'challengeId'] != null,
            'Required key "PlayIntegrityChallengeResponseDto[challengeId]" has a null value in JSON.');
        assert(json.containsKey(r'requestHash'),
            'Required key "PlayIntegrityChallengeResponseDto[requestHash]" is missing from JSON.');
        assert(json[r'requestHash'] != null,
            'Required key "PlayIntegrityChallengeResponseDto[requestHash]" has a null value in JSON.');
        assert(json.containsKey(r'cloudProjectNumber'),
            'Required key "PlayIntegrityChallengeResponseDto[cloudProjectNumber]" is missing from JSON.');
        assert(json[r'cloudProjectNumber'] != null,
            'Required key "PlayIntegrityChallengeResponseDto[cloudProjectNumber]" has a null value in JSON.');
        assert(json.containsKey(r'expiresAt'),
            'Required key "PlayIntegrityChallengeResponseDto[expiresAt]" is missing from JSON.');
        assert(json[r'expiresAt'] != null,
            'Required key "PlayIntegrityChallengeResponseDto[expiresAt]" has a null value in JSON.');
        return true;
      }());

      return PlayIntegrityChallengeResponseDto(
        challengeId: mapValueOfType<String>(json, r'challengeId')!,
        requestHash: mapValueOfType<String>(json, r'requestHash')!,
        cloudProjectNumber:
            mapValueOfType<String>(json, r'cloudProjectNumber')!,
        expiresAt: mapDateTime(json, r'expiresAt', r'')!,
      );
    }
    return null;
  }

  static List<PlayIntegrityChallengeResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <PlayIntegrityChallengeResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PlayIntegrityChallengeResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PlayIntegrityChallengeResponseDto> mapFromJson(
      dynamic json) {
    final map = <String, PlayIntegrityChallengeResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PlayIntegrityChallengeResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PlayIntegrityChallengeResponseDto-objects as value to a dart map
  static Map<String, List<PlayIntegrityChallengeResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<PlayIntegrityChallengeResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PlayIntegrityChallengeResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'challengeId',
    'requestHash',
    'cloudProjectNumber',
    'expiresAt',
  };
}
