//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestAssertionRequestDto {
  /// Returns a new [AppAttestAssertionRequestDto] instance.
  AppAttestAssertionRequestDto({
    required this.bundleId,
    required this.environment,
    required this.challengeId,
    required this.challenge,
    required this.keyId,
    required this.assertion,
  });

  String bundleId;

  AppAttestAssertionRequestDtoEnvironmentEnum environment;

  String challengeId;

  String challenge;

  String keyId;

  String assertion;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAttestAssertionRequestDto &&
          other.bundleId == bundleId &&
          other.environment == environment &&
          other.challengeId == challengeId &&
          other.challenge == challenge &&
          other.keyId == keyId &&
          other.assertion == assertion;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (bundleId.hashCode) +
      (environment.hashCode) +
      (challengeId.hashCode) +
      (challenge.hashCode) +
      (keyId.hashCode) +
      (assertion.hashCode);

  @override
  String toString() =>
      'AppAttestAssertionRequestDto[bundleId=$bundleId, environment=$environment, challengeId=$challengeId, challenge=$challenge, keyId=$keyId, assertion=$assertion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'bundleId'] = this.bundleId;
    json[r'environment'] = this.environment;
    json[r'challengeId'] = this.challengeId;
    json[r'challenge'] = this.challenge;
    json[r'keyId'] = this.keyId;
    json[r'assertion'] = this.assertion;
    return json;
  }

  /// Returns a new [AppAttestAssertionRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestAssertionRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'bundleId'),
            'Required key "AppAttestAssertionRequestDto[bundleId]" is missing from JSON.');
        assert(json[r'bundleId'] != null,
            'Required key "AppAttestAssertionRequestDto[bundleId]" has a null value in JSON.');
        assert(json.containsKey(r'environment'),
            'Required key "AppAttestAssertionRequestDto[environment]" is missing from JSON.');
        assert(json[r'environment'] != null,
            'Required key "AppAttestAssertionRequestDto[environment]" has a null value in JSON.');
        assert(json.containsKey(r'challengeId'),
            'Required key "AppAttestAssertionRequestDto[challengeId]" is missing from JSON.');
        assert(json[r'challengeId'] != null,
            'Required key "AppAttestAssertionRequestDto[challengeId]" has a null value in JSON.');
        assert(json.containsKey(r'challenge'),
            'Required key "AppAttestAssertionRequestDto[challenge]" is missing from JSON.');
        assert(json[r'challenge'] != null,
            'Required key "AppAttestAssertionRequestDto[challenge]" has a null value in JSON.');
        assert(json.containsKey(r'keyId'),
            'Required key "AppAttestAssertionRequestDto[keyId]" is missing from JSON.');
        assert(json[r'keyId'] != null,
            'Required key "AppAttestAssertionRequestDto[keyId]" has a null value in JSON.');
        assert(json.containsKey(r'assertion'),
            'Required key "AppAttestAssertionRequestDto[assertion]" is missing from JSON.');
        assert(json[r'assertion'] != null,
            'Required key "AppAttestAssertionRequestDto[assertion]" has a null value in JSON.');
        return true;
      }());

      return AppAttestAssertionRequestDto(
        bundleId: mapValueOfType<String>(json, r'bundleId')!,
        environment: AppAttestAssertionRequestDtoEnvironmentEnum.fromJson(
            json[r'environment'])!,
        challengeId: mapValueOfType<String>(json, r'challengeId')!,
        challenge: mapValueOfType<String>(json, r'challenge')!,
        keyId: mapValueOfType<String>(json, r'keyId')!,
        assertion: mapValueOfType<String>(json, r'assertion')!,
      );
    }
    return null;
  }

  static List<AppAttestAssertionRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestAssertionRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestAssertionRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestAssertionRequestDto> mapFromJson(dynamic json) {
    final map = <String, AppAttestAssertionRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestAssertionRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestAssertionRequestDto-objects as value to a dart map
  static Map<String, List<AppAttestAssertionRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AppAttestAssertionRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestAssertionRequestDto.listFromJson(
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
    'assertion',
  };
}

enum AppAttestAssertionRequestDtoEnvironmentEnum {
  development._(r'development'),
  production._(r'production'),
  ;

  /// Instantiate a new enum with the provided value.
  const AppAttestAssertionRequestDtoEnvironmentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AppAttestAssertionRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AppAttestAssertionRequestDtoEnvironmentEnum? fromJson(dynamic value) =>
      AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer()
          .decode(value);

  /// Returns a [List] containing instances of [AppAttestAssertionRequestDtoEnvironmentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AppAttestAssertionRequestDtoEnvironmentEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestAssertionRequestDtoEnvironmentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestAssertionRequestDtoEnvironmentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AppAttestAssertionRequestDtoEnvironmentEnum] to String,
/// and [decode] dynamic data back to [AppAttestAssertionRequestDtoEnvironmentEnum].
class AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer {
  factory AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer() =>
      _instance ??=
          const AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer._();

  const AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer._();

  String encode(AppAttestAssertionRequestDtoEnvironmentEnum data) =>
      data._value;

  /// Returns the instance of [AppAttestAssertionRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AppAttestAssertionRequestDtoEnvironmentEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is AppAttestAssertionRequestDtoEnvironmentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'development':
          return AppAttestAssertionRequestDtoEnvironmentEnum.development;
        case r'production':
          return AppAttestAssertionRequestDtoEnvironmentEnum.production;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AppAttestAssertionRequestDtoEnvironmentEnumTypeTransformer? _instance;
}
