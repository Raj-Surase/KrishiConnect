//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GovernmentSchemeCreate {
  /// Returns a new [GovernmentSchemeCreate] instance.
  GovernmentSchemeCreate({
    required this.title,
    required this.link,
    this.imageUrl,
    this.description,
    this.region = 'Maharashtra',
  });

  String title;

  String link;

  String? imageUrl;

  String? description;

  String region;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GovernmentSchemeCreate &&
    other.title == title &&
    other.link == link &&
    other.imageUrl == imageUrl &&
    other.description == description &&
    other.region == region;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (link.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (region.hashCode);

  @override
  String toString() => 'GovernmentSchemeCreate[title=$title, link=$link, imageUrl=$imageUrl, description=$description, region=$region]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'link'] = this.link;
    if (this.imageUrl != null) {
      json[r'image_url'] = this.imageUrl;
    } else {
      json[r'image_url'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
      json[r'region'] = this.region;
    return json;
  }

  /// Returns a new [GovernmentSchemeCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GovernmentSchemeCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GovernmentSchemeCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GovernmentSchemeCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GovernmentSchemeCreate(
        title: mapValueOfType<String>(json, r'title')!,
        link: mapValueOfType<String>(json, r'link')!,
        imageUrl: mapValueOfType<String>(json, r'image_url'),
        description: mapValueOfType<String>(json, r'description'),
        region: mapValueOfType<String>(json, r'region') ?? 'Maharashtra',
      );
    }
    return null;
  }

  static List<GovernmentSchemeCreate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GovernmentSchemeCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GovernmentSchemeCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GovernmentSchemeCreate> mapFromJson(dynamic json) {
    final map = <String, GovernmentSchemeCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GovernmentSchemeCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GovernmentSchemeCreate-objects as value to a dart map
  static Map<String, List<GovernmentSchemeCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GovernmentSchemeCreate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GovernmentSchemeCreate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'link',
  };
}

