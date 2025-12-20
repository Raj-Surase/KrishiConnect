//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MarketRate {
  /// Returns a new [MarketRate] instance.
  MarketRate({
    required this.cropId,
    required this.location,
    required this.date,
    required this.minPrice,
    required this.maxPrice,
    this.expectedPrice,
    this.unit = 'Quintal',
    required this.id,
    required this.createdById,
    required this.createdAt,
  });

  int cropId;

  String location;

  DateTime date;

  num minPrice;

  num maxPrice;

  num? expectedPrice;

  String unit;

  int id;

  int createdById;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MarketRate &&
    other.cropId == cropId &&
    other.location == location &&
    other.date == date &&
    other.minPrice == minPrice &&
    other.maxPrice == maxPrice &&
    other.expectedPrice == expectedPrice &&
    other.unit == unit &&
    other.id == id &&
    other.createdById == createdById &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (cropId.hashCode) +
    (location.hashCode) +
    (date.hashCode) +
    (minPrice.hashCode) +
    (maxPrice.hashCode) +
    (expectedPrice == null ? 0 : expectedPrice!.hashCode) +
    (unit.hashCode) +
    (id.hashCode) +
    (createdById.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'MarketRate[cropId=$cropId, location=$location, date=$date, minPrice=$minPrice, maxPrice=$maxPrice, expectedPrice=$expectedPrice, unit=$unit, id=$id, createdById=$createdById, createdAt=$createdAt]';

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
      json[r'id'] = this.id;
      json[r'created_by_id'] = this.createdById;
      json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [MarketRate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MarketRate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MarketRate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MarketRate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MarketRate(
        cropId: mapValueOfType<int>(json, r'crop_id')!,
        location: mapValueOfType<String>(json, r'location')!,
        date: mapDateTime(json, r'date', r'')!,
        minPrice: num.parse('${json[r'min_price']}'),
        maxPrice: num.parse('${json[r'max_price']}'),
        expectedPrice: json[r'expected_price'] == null
            ? null
            : num.parse('${json[r'expected_price']}'),
        unit: mapValueOfType<String>(json, r'unit') ?? 'Quintal',
        id: mapValueOfType<int>(json, r'id')!,
        createdById: mapValueOfType<int>(json, r'created_by_id')!,
        createdAt: mapDateTime(json, r'created_at', r'')!,
      );
    }
    return null;
  }

  static List<MarketRate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MarketRate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MarketRate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MarketRate> mapFromJson(dynamic json) {
    final map = <String, MarketRate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MarketRate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MarketRate-objects as value to a dart map
  static Map<String, List<MarketRate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MarketRate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MarketRate.listFromJson(entry.value, growable: growable,);
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
    'id',
    'created_by_id',
    'created_at',
  };
}

