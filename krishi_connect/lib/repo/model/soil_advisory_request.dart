//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SoilAdvisoryRequest {
  /// Returns a new [SoilAdvisoryRequest] instance.
  SoilAdvisoryRequest({
    required this.cropId,
    required this.soilType,
    required this.phLevel,
    required this.nutrientLevels,
    required this.weatherConditions,
  });

  /// ID of the selected crop.
  int cropId;

  /// e.g., Black soil, Red soil, Alluvial soil.
  String soilType;

  /// Soil pH level.
  num phLevel;

  /// e.g., NPK values, Organic Carbon content.
  String nutrientLevels;

  /// Current or expected weather conditions.
  String weatherConditions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SoilAdvisoryRequest &&
    other.cropId == cropId &&
    other.soilType == soilType &&
    other.phLevel == phLevel &&
    other.nutrientLevels == nutrientLevels &&
    other.weatherConditions == weatherConditions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cropId.hashCode) +
    (soilType.hashCode) +
    (phLevel.hashCode) +
    (nutrientLevels.hashCode) +
    (weatherConditions.hashCode);

  @override
  String toString() => 'SoilAdvisoryRequest[cropId=$cropId, soilType=$soilType, phLevel=$phLevel, nutrientLevels=$nutrientLevels, weatherConditions=$weatherConditions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'crop_id'] = this.cropId;
      json[r'soil_type'] = this.soilType;
      json[r'ph_level'] = this.phLevel;
      json[r'nutrient_levels'] = this.nutrientLevels;
      json[r'weather_conditions'] = this.weatherConditions;
    return json;
  }

  /// Returns a new [SoilAdvisoryRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SoilAdvisoryRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SoilAdvisoryRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SoilAdvisoryRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SoilAdvisoryRequest(
        cropId: mapValueOfType<int>(json, r'crop_id')!,
        soilType: mapValueOfType<String>(json, r'soil_type')!,
        phLevel: num.parse('${json[r'ph_level']}'),
        nutrientLevels: mapValueOfType<String>(json, r'nutrient_levels')!,
        weatherConditions: mapValueOfType<String>(json, r'weather_conditions')!,
      );
    }
    return null;
  }

  static List<SoilAdvisoryRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoilAdvisoryRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoilAdvisoryRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SoilAdvisoryRequest> mapFromJson(dynamic json) {
    final map = <String, SoilAdvisoryRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SoilAdvisoryRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SoilAdvisoryRequest-objects as value to a dart map
  static Map<String, List<SoilAdvisoryRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SoilAdvisoryRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SoilAdvisoryRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'crop_id',
    'soil_type',
    'ph_level',
    'nutrient_levels',
    'weather_conditions',
  };
}

