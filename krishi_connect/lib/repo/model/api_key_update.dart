//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiKeyUpdate {
  /// Returns a new [ApiKeyUpdate] instance.
  ApiKeyUpdate({
    this.apiKeyValue,
    this.isActive,
  });

  String? apiKeyValue;

  bool? isActive;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiKeyUpdate &&
    other.apiKeyValue == apiKeyValue &&
    other.isActive == isActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (apiKeyValue == null ? 0 : apiKeyValue!.hashCode) +
    (isActive == null ? 0 : isActive!.hashCode);

  @override
  String toString() => 'ApiKeyUpdate[apiKeyValue=$apiKeyValue, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.apiKeyValue != null) {
      json[r'api_key_value'] = this.apiKeyValue;
    } else {
      json[r'api_key_value'] = null;
    }
    if (this.isActive != null) {
      json[r'is_active'] = this.isActive;
    } else {
      json[r'is_active'] = null;
    }
    return json;
  }

  /// Returns a new [ApiKeyUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiKeyUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ApiKeyUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ApiKeyUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ApiKeyUpdate(
        apiKeyValue: mapValueOfType<String>(json, r'api_key_value'),
        isActive: mapValueOfType<bool>(json, r'is_active'),
      );
    }
    return null;
  }

  static List<ApiKeyUpdate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiKeyUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiKeyUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiKeyUpdate> mapFromJson(dynamic json) {
    final map = <String, ApiKeyUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiKeyUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiKeyUpdate-objects as value to a dart map
  static Map<String, List<ApiKeyUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiKeyUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiKeyUpdate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

