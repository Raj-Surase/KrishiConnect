//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiKey {
  /// Returns a new [ApiKey] instance.
  ApiKey({
    required this.serviceName,
    required this.apiKeyValue,
    this.isActive = true,
    required this.id,
    this.updatedById,
    required this.updatedAt,
  });

  /// e.g., GEMINI_API_KEY, WEATHER_API_KEY
  String serviceName;

  String apiKeyValue;

  bool isActive;

  int id;

  int? updatedById;

  DateTime updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiKey &&
    other.serviceName == serviceName &&
    other.apiKeyValue == apiKeyValue &&
    other.isActive == isActive &&
    other.id == id &&
    other.updatedById == updatedById &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (serviceName.hashCode) +
    (apiKeyValue.hashCode) +
    (isActive.hashCode) +
    (id.hashCode) +
    (updatedById == null ? 0 : updatedById!.hashCode) +
    (updatedAt.hashCode);

  @override
  String toString() => 'ApiKey[serviceName=$serviceName, apiKeyValue=$apiKeyValue, isActive=$isActive, id=$id, updatedById=$updatedById, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'service_name'] = this.serviceName;
      json[r'api_key_value'] = this.apiKeyValue;
      json[r'is_active'] = this.isActive;
      json[r'id'] = this.id;
    if (this.updatedById != null) {
      json[r'updated_by_id'] = this.updatedById;
    } else {
      json[r'updated_by_id'] = null;
    }
      json[r'updated_at'] = this.updatedAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ApiKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiKey[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiKey[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiKey(
        serviceName: mapValueOfType<String>(json, r'service_name')!,
        apiKeyValue: mapValueOfType<String>(json, r'api_key_value')!,
        isActive: mapValueOfType<bool>(json, r'is_active') ?? true,
        id: mapValueOfType<int>(json, r'id')!,
        updatedById: mapValueOfType<int>(json, r'updated_by_id'),
        updatedAt: mapDateTime(json, r'updated_at', r'')!,
      );
    }
    return null;
  }

  static List<ApiKey> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiKey> mapFromJson(dynamic json) {
    final map = <String, ApiKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiKey-objects as value to a dart map
  static Map<String, List<ApiKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiKey>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiKey.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'service_name',
    'api_key_value',
    'id',
    'updated_at',
  };
}

