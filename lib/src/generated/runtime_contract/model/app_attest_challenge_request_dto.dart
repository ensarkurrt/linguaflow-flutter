//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AppAttestChallengeRequestDto {
  /// Returns a new [AppAttestChallengeRequestDto] instance.
  AppAttestChallengeRequestDto({
    required this.bundleId,
    required this.environment,
  });

  String bundleId;

  AppAttestChallengeRequestDtoEnvironmentEnum environment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppAttestChallengeRequestDto &&
          other.bundleId == bundleId &&
          other.environment == environment;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (bundleId.hashCode) + (environment.hashCode);

  @override
  String toString() =>
      'AppAttestChallengeRequestDto[bundleId=$bundleId, environment=$environment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'bundleId'] = this.bundleId;
    json[r'environment'] = this.environment;
    return json;
  }

  /// Returns a new [AppAttestChallengeRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AppAttestChallengeRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'bundleId'),
            'Required key "AppAttestChallengeRequestDto[bundleId]" is missing from JSON.');
        assert(json[r'bundleId'] != null,
            'Required key "AppAttestChallengeRequestDto[bundleId]" has a null value in JSON.');
        assert(json.containsKey(r'environment'),
            'Required key "AppAttestChallengeRequestDto[environment]" is missing from JSON.');
        assert(json[r'environment'] != null,
            'Required key "AppAttestChallengeRequestDto[environment]" has a null value in JSON.');
        return true;
      }());

      return AppAttestChallengeRequestDto(
        bundleId: mapValueOfType<String>(json, r'bundleId')!,
        environment: AppAttestChallengeRequestDtoEnvironmentEnum.fromJson(
            json[r'environment'])!,
      );
    }
    return null;
  }

  static List<AppAttestChallengeRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestChallengeRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestChallengeRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AppAttestChallengeRequestDto> mapFromJson(dynamic json) {
    final map = <String, AppAttestChallengeRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AppAttestChallengeRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AppAttestChallengeRequestDto-objects as value to a dart map
  static Map<String, List<AppAttestChallengeRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AppAttestChallengeRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AppAttestChallengeRequestDto.listFromJson(
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
  };
}

enum AppAttestChallengeRequestDtoEnvironmentEnum {
  development._(r'development'),
  production._(r'production'),
  ;

  /// Instantiate a new enum with the provided value.
  const AppAttestChallengeRequestDtoEnvironmentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AppAttestChallengeRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AppAttestChallengeRequestDtoEnvironmentEnum? fromJson(dynamic value) =>
      AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer()
          .decode(value);

  /// Returns a [List] containing instances of [AppAttestChallengeRequestDtoEnvironmentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AppAttestChallengeRequestDtoEnvironmentEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AppAttestChallengeRequestDtoEnvironmentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AppAttestChallengeRequestDtoEnvironmentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AppAttestChallengeRequestDtoEnvironmentEnum] to String,
/// and [decode] dynamic data back to [AppAttestChallengeRequestDtoEnvironmentEnum].
class AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer {
  factory AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer() =>
      _instance ??=
          const AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer._();

  const AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer._();

  String encode(AppAttestChallengeRequestDtoEnvironmentEnum data) =>
      data._value;

  /// Returns the instance of [AppAttestChallengeRequestDtoEnvironmentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AppAttestChallengeRequestDtoEnvironmentEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is AppAttestChallengeRequestDtoEnvironmentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'development':
          return AppAttestChallengeRequestDtoEnvironmentEnum.development;
        case r'production':
          return AppAttestChallengeRequestDtoEnvironmentEnum.production;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AppAttestChallengeRequestDtoEnvironmentEnumTypeTransformer? _instance;
}
