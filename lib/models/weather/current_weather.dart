import 'weather_icons.dart';

class CurrentWeather {
  final int dt;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final List<WeatherIcons> weatherIcons;

  const CurrentWeather({
    required this.dt,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.weatherIcons,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
    dt: json['dt'],
    temperature: json['temp'].toDouble(),
    humidity: json['humidity'],
    windSpeed: json['wind_speed'],
    windDeg: json['wind_deg'],
    weatherIcons: List<WeatherIcons>.from(
      json['weather'].map((icons) => WeatherIcons.fromJson(icons)).toList(),
    ),
  );
}