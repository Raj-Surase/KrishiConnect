//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GovernmentScheme {
  /// Returns a new [GovernmentScheme] instance.
  GovernmentScheme({
    required this.title,
    required this.link,
    this.imageUrl,
    this.description,
    this.region = 'Maharashtra',
    required this.id,
    required this.createdById,
    required this.createdAt,
  });

  String title;

  String link;

  String? imageUrl;

  String? description;

  String region;

  int id;

  int createdById;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GovernmentScheme &&
    other.title == title &&
    other.link == link &&
    other.imageUrl == imageUrl &&
    other.description == description &&
    other.region == region &&
    other.id == id &&
    other.createdById == createdById &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (link.hashCode) +
    (imageUrl == null ? 0 : imageUrl!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (region.hashCode) +
    (id.hashCode) +
    (createdById.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'GovernmentScheme[title=$title, link=$link, imageUrl=$imageUrl, description=$description, region=$region, id=$id, createdById=$createdById, createdAt=$createdAt]';

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
      json[r'id'] = this.id;
      json[r'created_by_id'] = this.createdById;
      json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [GovernmentScheme] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GovernmentScheme? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GovernmentScheme[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GovernmentScheme[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GovernmentScheme(
        title: mapValueOfType<String>(json, r'title')!,
        link: mapValueOfType<String>(json, r'link')!,
        imageUrl: mapValueOfType<String>(json, r'image_url'),
        description: mapValueOfType<String>(json, r'description'),
        region: mapValueOfType<String>(json, r'region') ?? 'Maharashtra',
        id: mapValueOfType<int>(json, r'id')!,
        createdById: mapValueOfType<int>(json, r'created_by_id')!,
        createdAt: mapDateTime(json, r'created_at', r'')!,
      );
    }
    return null;
  }

  static List<GovernmentScheme> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GovernmentScheme>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GovernmentScheme.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GovernmentScheme> mapFromJson(dynamic json) {
    final map = <String, GovernmentScheme>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GovernmentScheme.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GovernmentScheme-objects as value to a dart map
  static Map<String, List<GovernmentScheme>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GovernmentScheme>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GovernmentScheme.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'link',
    'id',
    'created_by_id',
    'created_at',
  };
}

