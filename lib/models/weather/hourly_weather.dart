import 'weather_icons.dart';

class HourlyWeather {
  final int dt;
  final double temperature;
  final List<WeatherIcons> weatherIcons;

  const HourlyWeather({
    required this.dt,
    required this.temperature,
    required this.weatherIcons,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
    dt: json['dt'],
    temperature: json['temp'].toDouble(),
    weatherIcons: List<WeatherIcons>.from(
      json['weather'].map((icons) => WeatherIcons.fromJson(icons)).toList(),
    ),
  );
}