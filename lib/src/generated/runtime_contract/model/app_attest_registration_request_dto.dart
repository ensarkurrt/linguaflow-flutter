//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestRegistrationRequestDto {
  /// Returns a new [AppAttestRegistrationRequestDto] instance.
  AppAttestRegistrationRequestDto({
    required this.bundleId,
    required this.environment,
    required this.challengeId,
    required this.challenge,
    required this.keyId,
    required this.attestation,
  });

  String bundleId;

  AppAttestRegistrationRequestDtoEnvironmentEnum environment;

  String challengeId;

  String challenge;

  String keyId;

  String attestation;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAttestRegistrationRequestDto &&
          other.bundleId == bundleId &&
          other.environment == environment &&
          other.challengeId == challengeId &&
          other.challenge == challenge &&
          other.keyId == keyId &&
          other.attestation == attestation;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (bundleId.hashCode) +
      (environment.hashCode) +
      (challengeId.hashCode) +
      (challenge.hashCode) +
      (keyId.hashCode) +
      (attestation.hashCode);

  @override
  String toString() =>
      'AppAttestRegistrationRequestDto[bundleId=$bundleId, environment=$environment, challengeId=$challengeId, challenge=$challenge, keyId=$keyId, attestation=$attestation]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'bundleId'] = this.bundleId;
    json[r'environment'] = this.environment;
    json[r'challengeId'] = this.challengeId;
    json[r'challenge'] = this.challenge;
    json[r'keyId'] = this.keyId;
    json[r'attestation'] = this.attestation;
    return json;
  }

  /// Returns a new [AppAttestRegistrationRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestRegistrationRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'bundleId'),
            'Required key "AppAttestRegistrationRequestDto[bundleId]" is missing from JSON.');
        assert(json[r'bundleId'] != null,
            'Required key "AppAttestRegistrationRequestDto[bundleId]" has a null value in JSON.');
        assert(json.containsKey(r'environment'),
            'Required key "AppAttestRegistrationRequestDto[environment]" is missing from JSON.');
        assert(json[r'environment'] != null,
            'Required key "AppAttestRegistrationRequestDto[environment]" has a null value in JSON.');
        assert(json.containsKey(r'challengeId'),
            'Required key "AppAttestRegistrationRequestDto[challengeId]" is missing from JSON.');
        assert(json[r'challengeId'] != null,
            'Required key "AppAttestRegistrationRequestDto[challengeId]" has a null value in JSON.');
        assert(json.containsKey(r'challenge'),
            'Required key "AppAttestRegistrationRequestDto[challenge]" is missing from JSON.');
        assert(json[r'challenge'] != null,
            'Required key "AppAttestRegistrationRequestDto[challenge]" has a null value in JSON.');
        assert(json.containsKey(r'keyId'),
            'Required key "AppAttestRegistrationRequestDto[keyId]" is missing from JSON.');
        assert(json[r'keyId'] != null,
            'Required key "AppAttestRegistrationRequestDto[keyId]" has a null value in JSON.');
        assert(json.containsKey(r'attestation'),
            'Required key "AppAttestRegistrationRequestDto[attestation]" is missing from JSON.');
        assert(json[r'attestation'] != null,
            'Required key "AppAttestRegistrationRequestDto[attestation]" has a null value in JSON.');
        return true;
      }());

      return AppAttestRegistrationRequestDto(
        bundleId: mapValueOfType<String>(json, r'bundleId')!,
        environment: AppAttestRegistrationRequestDtoEnvironmentEnum.fromJson(
            json[r'environment'])!,
        challengeId: mapValueOfType<String>(json, r'challengeId')!,
        challenge: mapValueOfType<String>(json, r'challenge')!,
        keyId: mapValueOfType<String>(json, r'keyId')!,
        attestation: mapValueOfType<String>(json, r'attestation')!,
      );
    }
    return null;
  }

  static List<AppAttestRegistrationRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestRegistrationRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestRegistrationRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestRegistrationRequestDto> mapFromJson(
      dynamic json) {
    final map = <String, AppAttestRegistrationRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestRegistrationRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestRegistrationRequestDto-objects as value to a dart map
  static Map<String, List<AppAttestRegistrationRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AppAttestRegistrationRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestRegistrationRequestDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'bundleId',
    'environment',
    'challengeId',
    'challenge',
    'keyId',
    'attestation',
  };
}

enum AppAttestRegistrationRequestDtoEnvironmentEnum {
  development._(r'development'),
  production._(r'production'),
  ;

  /// Instantiate a new enum with the provided value.
  const AppAttestRegistrationRequestDtoEnvironmentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AppAttestRegistrationRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AppAttestRegistrationRequestDtoEnvironmentEnum? fromJson(
          dynamic value) =>
      AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer()
          .decode(value);

  /// Returns a [List] containing instances of [AppAttestRegistrationRequestDtoEnvironmentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AppAttestRegistrationRequestDtoEnvironmentEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestRegistrationRequestDtoEnvironmentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value =
            AppAttestRegistrationRequestDtoEnvironmentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AppAttestRegistrationRequestDtoEnvironmentEnum] to String,
/// and [decode] dynamic data back to [AppAttestRegistrationRequestDtoEnvironmentEnum].
class AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer {
  factory AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer() =>
      _instance ??=
          const AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer
              ._();

  const AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer._();

  String encode(AppAttestRegistrationRequestDtoEnvironmentEnum data) =>
      data._value;

  /// Returns the instance of [AppAttestRegistrationRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AppAttestRegistrationRequestDtoEnvironmentEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is AppAttestRegistrationRequestDtoEnvironmentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'development':
          return AppAttestRegistrationRequestDtoEnvironmentEnum.development;
        case r'production':
          return AppAttestRegistrationRequestDtoEnvironmentEnum.production;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AppAttestRegistrationRequestDtoEnvironmentEnumTypeTransformer?
      _instance;
}
