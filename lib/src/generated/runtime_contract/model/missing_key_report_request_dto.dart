//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MissingKeyReportRequestDto {
  /// Returns a new [MissingKeyReportRequestDto] instance.
  MissingKeyReportRequestDto({
    required this.requestId,
    this.releaseId,
    required this.locale,
    this.appVersion = '',
    this.platform,
    this.keys = const [],
  });

  String requestId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? releaseId;

  String locale;

  String appVersion;

  MissingKeyReportRequestDtoPlatformEnum? platform;

  List<String> keys;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MissingKeyReportRequestDto &&
          other.requestId == requestId &&
          other.releaseId == releaseId &&
          other.locale == locale &&
          other.appVersion == appVersion &&
          other.platform == platform &&
          _deepEquality.equals(other.keys, keys);

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (requestId.hashCode) +
      (releaseId == null ? 0 : releaseId!.hashCode) +
      (locale.hashCode) +
      (appVersion.hashCode) +
      (platform == null ? 0 : platform!.hashCode) +
      (keys.hashCode);

  @override
  String toString() =>
      'MissingKeyReportRequestDto[requestId=$requestId, releaseId=$releaseId, locale=$locale, appVersion=$appVersion, platform=$platform, keys=$keys]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'requestId'] = this.requestId;
    if (this.releaseId != null) {
      json[r'releaseId'] = this.releaseId;
    } else {
      json[r'releaseId'] = null;
    }
    json[r'locale'] = this.locale;
    json[r'appVersion'] = this.appVersion;
    if (this.platform != null) {
      json[r'platform'] = this.platform;
    } else {
      json[r'platform'] = null;
    }
    json[r'keys'] = this.keys;
    return json;
  }

  /// Returns a new [MissingKeyReportRequestDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MissingKeyReportRequestDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'requestId'),
            'Required key "MissingKeyReportRequestDto[requestId]" is missing from JSON.');
        assert(json[r'requestId'] != null,
            'Required key "MissingKeyReportRequestDto[requestId]" has a null value in JSON.');
        assert(json.containsKey(r'locale'),
            'Required key "MissingKeyReportRequestDto[locale]" is missing from JSON.');
        assert(json[r'locale'] != null,
            'Required key "MissingKeyReportRequestDto[locale]" has a null value in JSON.');
        assert(json.containsKey(r'appVersion'),
            'Required key "MissingKeyReportRequestDto[appVersion]" is missing from JSON.');
        assert(json[r'appVersion'] != null,
            'Required key "MissingKeyReportRequestDto[appVersion]" has a null value in JSON.');
        assert(json.containsKey(r'keys'),
            'Required key "MissingKeyReportRequestDto[keys]" is missing from JSON.');
        assert(json[r'keys'] != null,
            'Required key "MissingKeyReportRequestDto[keys]" has a null value in JSON.');
        return true;
      }());

      return MissingKeyReportRequestDto(
        requestId: mapValueOfType<String>(json, r'requestId')!,
        releaseId: mapValueOfType<String>(json, r'releaseId'),
        locale: mapValueOfType<String>(json, r'locale')!,
        appVersion: mapValueOfType<String>(json, r'appVersion')!,
        platform:
            MissingKeyReportRequestDtoPlatformEnum.fromJson(json[r'platform']),
        keys: json[r'keys'] is Iterable
            ? (json[r'keys'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<MissingKeyReportRequestDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MissingKeyReportRequestDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MissingKeyReportRequestDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MissingKeyReportRequestDto> mapFromJson(dynamic json) {
    final map = <String, MissingKeyReportRequestDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MissingKeyReportRequestDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MissingKeyReportRequestDto-objects as value to a dart map
  static Map<String, List<MissingKeyReportRequestDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<MissingKeyReportRequestDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MissingKeyReportRequestDto.listFromJson(
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
    'locale',
    'appVersion',
    'keys',
  };
}

enum MissingKeyReportRequestDtoPlatformEnum {
  flutter._(r'flutter'),
  react._(r'react'),
  ios._(r'ios'),
  android._(r'android'),
  web._(r'web'),
  unknown._(r'unknown'),
  ;

  /// Instantiate a new enum with the provided value.
  const MissingKeyReportRequestDtoPlatformEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [MissingKeyReportRequestDtoPlatformEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static MissingKeyReportRequestDtoPlatformEnum? fromJson(dynamic value) =>
      MissingKeyReportRequestDtoPlatformEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [MissingKeyReportRequestDtoPlatformEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<MissingKeyReportRequestDtoPlatformEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <MissingKeyReportRequestDtoPlatformEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MissingKeyReportRequestDtoPlatformEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MissingKeyReportRequestDtoPlatformEnum] to String,
/// and [decode] dynamic data back to [MissingKeyReportRequestDtoPlatformEnum].
class MissingKeyReportRequestDtoPlatformEnumTypeTransformer {
  factory MissingKeyReportRequestDtoPlatformEnumTypeTransformer() =>
      _instance ??=
          const MissingKeyReportRequestDtoPlatformEnumTypeTransformer._();

  const MissingKeyReportRequestDtoPlatformEnumTypeTransformer._();

  String encode(MissingKeyReportRequestDtoPlatformEnum data) => data._value;

  /// Returns the instance of [MissingKeyReportRequestDtoPlatformEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MissingKeyReportRequestDtoPlatformEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is MissingKeyReportRequestDtoPlatformEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'flutter':
          return MissingKeyReportRequestDtoPlatformEnum.flutter;
        case r'react':
          return MissingKeyReportRequestDtoPlatformEnum.react;
        case r'ios':
          return MissingKeyReportRequestDtoPlatformEnum.ios;
        case r'android':
          return MissingKeyReportRequestDtoPlatformEnum.android;
        case r'web':
          return MissingKeyReportRequestDtoPlatformEnum.web;
        case r'unknown':
          return MissingKeyReportRequestDtoPlatformEnum.unknown;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static MissingKeyReportRequestDtoPlatformEnumTypeTransformer? _instance;
}
