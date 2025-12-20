class WeatherModel {
  final double temperature;
  final String condition;
  final String iconUrl;
  final double windKph;
  final int humidity;
  final String location;

  WeatherModel({
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.windKph,
    required this.humidity,
    required this.location,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['current']['temp_c'].toDouble(),
      condition: json['current']['condition']['text'],
      iconUrl: "https:${json['current']['condition']['icon']}",
      windKph: json['current']['wind_kph'].toDouble(),
      humidity: json['current']['humidity'],
      location: json['location']['name'],
    );
  }
}
