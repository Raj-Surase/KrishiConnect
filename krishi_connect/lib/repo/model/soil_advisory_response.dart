//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SoilAdvisoryResponse {
  /// Returns a new [SoilAdvisoryResponse] instance.
  SoilAdvisoryResponse({
    required this.cropName,
    required this.advisory,
  });

  String cropName;

  /// Detailed, localized advisory from the AI.
  String advisory;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SoilAdvisoryResponse &&
    other.cropName == cropName &&
    other.advisory == advisory;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cropName.hashCode) +
    (advisory.hashCode);

  @override
  String toString() => 'SoilAdvisoryResponse[cropName=$cropName, advisory=$advisory]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'crop_name'] = this.cropName;
      json[r'advisory'] = this.advisory;
    return json;
  }

  /// Returns a new [SoilAdvisoryResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SoilAdvisoryResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SoilAdvisoryResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SoilAdvisoryResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SoilAdvisoryResponse(
        cropName: mapValueOfType<String>(json, r'crop_name')!,
        advisory: mapValueOfType<String>(json, r'advisory')!,
      );
    }
    return null;
  }

  static List<SoilAdvisoryResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SoilAdvisoryResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SoilAdvisoryResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SoilAdvisoryResponse> mapFromJson(dynamic json) {
    final map = <String, SoilAdvisoryResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SoilAdvisoryResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SoilAdvisoryResponse-objects as value to a dart map
  static Map<String, List<SoilAdvisoryResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SoilAdvisoryResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SoilAdvisoryResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'crop_name',
    'advisory',
  };
}

