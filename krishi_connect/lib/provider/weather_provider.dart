// weather_provider.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:krishi_connect/repo/model/weather.dart';

class WeatherProvider with ChangeNotifier {
  static const _apiKey = "8c741249a1c94f92b6f173421252012";
  static const _baseUrl = "https://api.weatherapi.com/v1/forecast.json";

  WeatherFutureResponse? _weather;
  bool _loading = false;
  String? _error;
  int _selectedDayIndex = 0;

  WeatherFutureResponse? get weather => _weather;
  bool get loading => _loading;
  String? get error => _error;
  int get selectedDayIndex => _selectedDayIndex;

  void selectDay(int index) {
    _selectedDayIndex = index;
    notifyListeners();
  }

  Future<void> fetchForecast({required String location}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final uri = Uri.parse(
        "$_baseUrl?key=$_apiKey&q=$location&days=10&aqi=no&alerts=no",
      );

      final res = await http.get(uri);

      if (res.statusCode != 200) {
        final err = jsonDecode(res.body);
        throw Exception(err['error']['message']);
      }

      final data = jsonDecode(res.body);
      _weather = WeatherFutureResponse.fromJson(data);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
