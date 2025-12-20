//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CropCreate {
  /// Returns a new [CropCreate] instance.
  CropCreate({
    required this.name,
    this.imageUrl,
    this.details,
    this.context,
  });

  String name;

  String? imageUrl;

  String? details;

  String? context;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CropCreate &&
    other.name == name &&
    other.imageUrl == imageUrl &&
    other.details == details &&
    other.context == context;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (details == null ? 0 : details!.hashCode) +
    (context == null ? 0 : context!.hashCode);

  @override
  String toString() => 'CropCreate[name=$name, imageUrl=$imageUrl, details=$details, context=$context]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.imageUrl != null) {
      json[r'image_url'] = this.imageUrl;
    } else {
      json[r'image_url'] = null;
    }
    if (this.details != null) {
      json[r'details'] = this.details;
    } else {
      json[r'details'] = null;
    }
    if (this.context != null) {
      json[r'context'] = this.context;
    } else {
      json[r'context'] = null;
    }
    return json;
  }

  /// Returns a new [CropCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CropCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CropCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CropCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CropCreate(
        name: mapValueOfType<String>(json, r'name')!,
        imageUrl: mapValueOfType<String>(json, r'image_url'),
        details: mapValueOfType<String>(json, r'details'),
        context: mapValueOfType<String>(json, r'context'),
      );
    }
    return null;
  }

  static List<CropCreate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CropCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CropCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CropCreate> mapFromJson(dynamic json) {
    final map = <String, CropCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CropCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CropCreate-objects as value to a dart map
  static Map<String, List<CropCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CropCreate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CropCreate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
  };
}

