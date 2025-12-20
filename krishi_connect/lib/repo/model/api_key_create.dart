//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiKeyCreate {
  /// Returns a new [ApiKeyCreate] instance.
  ApiKeyCreate({
    required this.serviceName,
    required this.apiKeyValue,
    this.isActive = true,
  });

  /// e.g., GEMINI_API_KEY, WEATHER_API_KEY
  String serviceName;

  String apiKeyValue;

  bool isActive;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiKeyCreate &&
    other.serviceName == serviceName &&
    other.apiKeyValue == apiKeyValue &&
    other.isActive == isActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (serviceName.hashCode) +
    (apiKeyValue.hashCode) +
    (isActive.hashCode);

  @override
  String toString() => 'ApiKeyCreate[serviceName=$serviceName, apiKeyValue=$apiKeyValue, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'service_name'] = this.serviceName;
      json[r'api_key_value'] = this.apiKeyValue;
      json[r'is_active'] = this.isActive;
    return json;
  }

  /// Returns a new [ApiKeyCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiKeyCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiKeyCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiKeyCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiKeyCreate(
        serviceName: mapValueOfType<String>(json, r'service_name')!,
        apiKeyValue: mapValueOfType<String>(json, r'api_key_value')!,
        isActive: mapValueOfType<bool>(json, r'is_active') ?? true,
      );
    }
    return null;
  }

  static List<ApiKeyCreate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiKeyCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiKeyCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiKeyCreate> mapFromJson(dynamic json) {
    final map = <String, ApiKeyCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiKeyCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiKeyCreate-objects as value to a dart map
  static Map<String, List<ApiKeyCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiKeyCreate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiKeyCreate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'service_name',
    'api_key_value',
  };
}

