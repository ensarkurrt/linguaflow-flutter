//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IntegrityGrantResponseDto {
  /// Returns a new [IntegrityGrantResponseDto] instance.
  IntegrityGrantResponseDto({
    required this.token,
    required this.expiresAt,
  });

  String token;

  DateTime expiresAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IntegrityGrantResponseDto &&
          other.token == token &&
          other.expiresAt == expiresAt;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (token.hashCode) + (expiresAt.hashCode);

  @override
  String toString() =>
      'IntegrityGrantResponseDto[token=$token, expiresAt=$expiresAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'token'] = this.token;
    json[r'expiresAt'] = this.expiresAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [IntegrityGrantResponseDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IntegrityGrantResponseDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'),
            'Required key "IntegrityGrantResponseDto[token]" is missing from JSON.');
        assert(json[r'token'] != null,
            'Required key "IntegrityGrantResponseDto[token]" has a null value in JSON.');
        assert(json.containsKey(r'expiresAt'),
            'Required key "IntegrityGrantResponseDto[expiresAt]" is missing from JSON.');
        assert(json[r'expiresAt'] != null,
            'Required key "IntegrityGrantResponseDto[expiresAt]" has a null value in JSON.');
        return true;
      }());

      return IntegrityGrantResponseDto(
        token: mapValueOfType<String>(json, r'token')!,
        expiresAt: mapDateTime(json, r'expiresAt', r'')!,
      );
    }
    return null;
  }

  static List<IntegrityGrantResponseDto> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IntegrityGrantResponseDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IntegrityGrantResponseDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IntegrityGrantResponseDto> mapFromJson(dynamic json) {
    final map = <String, IntegrityGrantResponseDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IntegrityGrantResponseDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IntegrityGrantResponseDto-objects as value to a dart map
  static Map<String, List<IntegrityGrantResponseDto>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<IntegrityGrantResponseDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IntegrityGrantResponseDto.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
    'expiresAt',
  };
}
