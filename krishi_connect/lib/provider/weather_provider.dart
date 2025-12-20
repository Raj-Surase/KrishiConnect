import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_connect/repo/model/weather.dart';

class WeatherProvider with ChangeNotifier {
  static const String _apiKey =
      '8c741249a1c94f92b6f173421252012'; // 🔴 put key here
  static const String _baseUrl = 'https://api.weatherapi.com/v1/current.json';

  WeatherModel? _weather;
  bool _loading = false;
  String? _error;

  bool _fetchedOnce = false;

  WeatherModel? get weather => _weather;
  bool get loading => _loading;
  String? get error => _error;

  /// 🚀 Fetch weather ONLY ONCE
  Future<void> fetchWeatherOnce({
    required String location, // e.g. Pune, Maharashtra
  }) async {
    if (_fetchedOnce) return;

    _loading = true;
    notifyListeners();

    try {
      final uri = Uri.parse('$_baseUrl?key=$_apiKey&q=$location&aqi=no');

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception("Failed to fetch weather");
      }

      final jsonData = jsonDecode(response.body);
      _weather = WeatherModel.fromJson(jsonData);
      _fetchedOnce = true;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
