//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserCreate {
  /// Returns a new [UserCreate] instance.
  UserCreate({
    required this.username,
    required this.role,
    required this.password,
  });

  String username;

  String role;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserCreate &&
    other.username == username &&
    other.role == role &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (username.hashCode) +
    (role.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'UserCreate[username=$username, role=$role, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'username'] = this.username;
      json[r'role'] = this.role;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [UserCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserCreate(
        username: mapValueOfType<String>(json, r'username')!,
        role: mapValueOfType<String>(json, r'role')!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<UserCreate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserCreate> mapFromJson(dynamic json) {
    final map = <String, UserCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserCreate-objects as value to a dart map
  static Map<String, List<UserCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserCreate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserCreate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'role',
    'password',
  };
}

