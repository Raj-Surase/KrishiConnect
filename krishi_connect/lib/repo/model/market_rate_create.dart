//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MarketRateCreate {
  /// Returns a new [MarketRateCreate] instance.
  MarketRateCreate({
    required this.cropId,
    required this.location,
    required this.date,
    required this.minPrice,
    required this.maxPrice,
    this.expectedPrice,
    this.unit = 'Quintal',
  });

  int cropId;

  String location;

  DateTime date;

  num minPrice;

  num maxPrice;

  num? expectedPrice;

  String unit;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MarketRateCreate &&
    other.cropId == cropId &&
    other.location == location &&
    other.date == date &&
    other.minPrice == minPrice &&
    other.maxPrice == maxPrice &&
    other.expectedPrice == expectedPrice &&
    other.unit == unit;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cropId.hashCode) +
    (location.hashCode) +
    (date.hashCode) +
    (minPrice.hashCode) +
    (maxPrice.hashCode) +
    (expectedPrice == null ? 0 : expectedPrice!.hashCode) +
    (unit.hashCode);

  @override
  String toString() => 'MarketRateCreate[cropId=$cropId, location=$location, date=$date, minPrice=$minPrice, maxPrice=$maxPrice, expectedPrice=$expectedPrice, unit=$unit]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'crop_id'] = this.cropId;
      json[r'location'] = this.location;
      json[r'date'] = _dateFormatter.format(this.date.toUtc());
      json[r'min_price'] = this.minPrice;
      json[r'max_price'] = this.maxPrice;
    if (this.expectedPrice != null) {
      json[r'expected_price'] = this.expectedPrice;
    } else {
      json[r'expected_price'] = null;
    }
      json[r'unit'] = this.unit;
    return json;
  }

  /// Returns a new [MarketRateCreate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MarketRateCreate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MarketRateCreate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MarketRateCreate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MarketRateCreate(
        cropId: mapValueOfType<int>(json, r'crop_id')!,
        location: mapValueOfType<String>(json, r'location')!,
        date: mapDateTime(json, r'date', r'')!,
        minPrice: num.parse('${json[r'min_price']}'),
        maxPrice: num.parse('${json[r'max_price']}'),
        expectedPrice: json[r'expected_price'] == null
            ? null
            : num.parse('${json[r'expected_price']}'),
        unit: mapValueOfType<String>(json, r'unit') ?? 'Quintal',
      );
    }
    return null;
  }

  static List<MarketRateCreate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MarketRateCreate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MarketRateCreate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MarketRateCreate> mapFromJson(dynamic json) {
    final map = <String, MarketRateCreate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MarketRateCreate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MarketRateCreate-objects as value to a dart map
  static Map<String, List<MarketRateCreate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MarketRateCreate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MarketRateCreate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'crop_id',
    'location',
    'date',
    'min_price',
    'max_price',
  };
}

