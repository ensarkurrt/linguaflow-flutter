//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestChallengeResponseDto {
  /// Returns a new [AppAttestChallengeResponseDto] instance.
  AppAttestChallengeResponseDto({
    required this.challengeId,
    required this.challenge,
    required this.expiresAt,
  });

  String challengeId;

  String challenge;

  DateTime expiresAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAttestChallengeResponseDto &&
          other.challengeId == challengeId &&
          other.challenge == challenge &&
          other.expiresAt == expiresAt;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (challengeId.hashCode) + (challenge.hashCode) + (expiresAt.hashCode);

  @override
  String toString() =>
      'AppAttestChallengeResponseDto[challengeId=$challengeId, challenge=$challenge, expiresAt=$expiresAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'challengeId'] = this.challengeId;
    json[r'challenge'] = this.challenge;
    json[r'expiresAt'] = this.expiresAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [AppAttestChallengeResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestChallengeResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'challengeId'),
            'Required key "AppAttestChallengeResponseDto[challengeId]" is missing from JSON.');
        assert(json[r'challengeId'] != null,
            'Required key "AppAttestChallengeResponseDto[challengeId]" has a null value in JSON.');
        assert(json.containsKey(r'challenge'),
            'Required key "AppAttestChallengeResponseDto[challenge]" is missing from JSON.');
        assert(json[r'challenge'] != null,
            'Required key "AppAttestChallengeResponseDto[challenge]" has a null value in JSON.');
        assert(json.containsKey(r'expiresAt'),
            'Required key "AppAttestChallengeResponseDto[expiresAt]" is missing from JSON.');
        assert(json[r'expiresAt'] != null,
            'Required key "AppAttestChallengeResponseDto[expiresAt]" has a null value in JSON.');
        return true;
      }());

      return AppAttestChallengeResponseDto(
        challengeId: mapValueOfType<String>(json, r'challengeId')!,
        challenge: mapValueOfType<String>(json, r'challenge')!,
        expiresAt: mapDateTime(json, r'expiresAt', r'')!,
      );
    }
    return null;
  }

  static List<AppAttestChallengeResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestChallengeResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestChallengeResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestChallengeResponseDto> mapFromJson(dynamic json) {
    final map = <String, AppAttestChallengeResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestChallengeResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestChallengeResponseDto-objects as value to a dart map
  static Map<String, List<AppAttestChallengeResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AppAttestChallengeResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestChallengeResponseDto.listFromJson(
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
    'challenge',
    'expiresAt',
  };
}
