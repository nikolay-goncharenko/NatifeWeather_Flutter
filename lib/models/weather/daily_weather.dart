import 'temperature.dart';
import 'weather_icons.dart';

class DailyWeather {
  final int dt;
  final Temperature temperature;
  final List<WeatherIcons> weatherIcons;

  const DailyWeather({
    required this.dt,
    required this.temperature,
    required this.weatherIcons
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) => DailyWeather(
    dt: json['dt'],
    temperature: Temperature.fromJson(json['temp']),
    weatherIcons: List<WeatherIcons>.from(
      json['weather'].map((icons) => WeatherIcons.fromJson(icons)).toList(),
    ),
  );
}
