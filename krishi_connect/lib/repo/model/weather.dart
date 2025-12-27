// weather_model.dart

class WeatherFutureResponse {
  final Location location;
  final Forecast forecast;

  WeatherFutureResponse({required this.location, required this.forecast});

  factory WeatherFutureResponse.fromJson(Map<String, dynamic> json) {
    return WeatherFutureResponse(
      location: Location.fromJson(json['location']),
      forecast: Forecast.fromJson(json['forecast']),
    );
  }
}

/* ---------------- LOCATION ---------------- */

class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json['name'],
    region: json['region'],
    country: json['country'],
    lat: json['lat'].toDouble(),
    lon: json['lon'].toDouble(),
    tzId: json['tz_id'],
    localtime: json['localtime'],
  );
}

/* ---------------- FORECAST ---------------- */

class Forecast {
  final List<ForecastDay> forecastDays;

  Forecast({required this.forecastDays});

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    forecastDays: (json['forecastday'] as List)
        .map((e) => ForecastDay.fromJson(e))
        .toList(),
  );
}

class ForecastDay {
  final String date;
  final DayWeather day;
  final Astro astro;
  final List<HourWeather> hours;

  ForecastDay({
    required this.date,
    required this.day,
    required this.astro,
    required this.hours,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
    date: json['date'],
    day: DayWeather.fromJson(json['day']),
    astro: Astro.fromJson(json['astro']),
    hours: (json['hour'] as List).map((e) => HourWeather.fromJson(e)).toList(),
  );
}

/* ---------------- DAY SUMMARY ---------------- */

class DayWeather {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final int avghumidity;
  final double uv;
  final int dailyChanceOfRain;
  final Condition condition;

  DayWeather({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.avghumidity,
    required this.uv,
    required this.dailyChanceOfRain,
    required this.condition,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    double _d(dynamic v, [double def = 0]) =>
        v == null ? def : (v as num).toDouble();

    int _i(dynamic v, [int def = 0]) => v == null ? def : (v as num).toInt();

    return DayWeather(
      maxtempC: _d(json['maxtemp_c']),
      mintempC: _d(json['mintemp_c']),
      avgtempC: _d(json['avgtemp_c']),
      avghumidity: _i(json['avghumidity']),
      uv: _d(json['uv']),
      dailyChanceOfRain: _i(json['daily_chance_of_rain']),
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}

/* ---------------- ASTRO ---------------- */

class Astro {
  final String sunrise;
  final String sunset;
  final String moonPhase;

  Astro({required this.sunrise, required this.sunset, required this.moonPhase});

  factory Astro.fromJson(Map<String, dynamic> json) => Astro(
    sunrise: json['sunrise'],
    sunset: json['sunset'],
    moonPhase: json['moon_phase'],
  );
}

/* ---------------- HOURLY ---------------- */

class HourWeather {
  final String time;
  final double temp;
  final int isDay;
  final int humidity;
  final double windKph;
  final Condition condition;

  HourWeather({
    required this.time,
    required this.temp,
    required this.isDay,
    required this.humidity,
    required this.windKph,
    required this.condition,
  });

  factory HourWeather.fromJson(Map<String, dynamic> json) => HourWeather(
    time: json['time'],
    temp: (json['temp_c'] as num).toDouble(),
    isDay: json['is_day'],
    humidity: (json['humidity'] as num).toInt(), // ✅ FIX
    windKph: (json['wind_kph'] as num).toDouble(),
    condition: json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : Condition(text: "Unknown", icon: ""),
  );
}

/* ---------------- COMMON CONDITION ---------------- */

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      Condition(text: json['text'], icon: "https:${json['icon']}");
}
