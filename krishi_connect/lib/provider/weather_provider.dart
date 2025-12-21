// weather_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/model/weather.dart';

class WeatherProvider with ChangeNotifier {
  WeatherFutureResponse? _weather;
  bool _loading = false;
  String? _error;

  WeatherFutureResponse? get weather => _weather;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> fetchFutureWeather({
    required String location,
    required String date, // yyyy-MM-dd
  }) async {
    _loading = true;
    notifyListeners();

    try {
      /// 🔁 Replace `mockWeatherJson` with API response when moving to production
      final Map<String, dynamic> jsonData = jsonDecode(
        mockWeatherJson,
      ); // <-- ONE LINE TO SWITCH

      _weather = WeatherFutureResponse.fromJson(jsonData);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

const String mockWeatherJson = '''
{
  "location": {
    "name": "Kopargaon",
    "region": "Maharashtra",
    "country": "India",
    "lat": 19.8833,
    "lon": 74.4833,
    "tz_id": "Asia/Kolkata",
    "localtime_epoch": 1766303792,
    "localtime": "2025-12-21 13:26"
  },
  "forecast": {
    "forecastday": [
      {
        "date": "2026-01-15",
        "date_epoch": 1768435200,
        "day": {
          "maxtemp_c": 29.5,
          "mintemp_c": 16.2,
          "avgtemp_c": 22.7,
          "avghumidity": 39,
          "condition": {
            "text": "Sunny",
            "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
            "code": 1000
          },
          "uv": 6
        },
        "astro": {
          "sunrise": "07:10 AM",
          "sunset": "06:13 PM",
          "moon_phase": "Waning Crescent"
        },
        "hour": []
      }
    ]
  }
}
''';
