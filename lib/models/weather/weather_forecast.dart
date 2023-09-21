import 'current_weather.dart';
import 'daily_weather.dart';
import 'hourly_weather.dart';

class WeatherForecast {
  final double latitude;
  final double longitude;
  final CurrentWeather current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  const WeatherForecast({
    required this.latitude,
    required this.longitude,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) => WeatherForecast(
    latitude: json['lat'].toDouble(),
    longitude: json['lon'].toDouble(),
    current: CurrentWeather.fromJson(json['current']),
    hourly: List<HourlyWeather>.from(
      json['hourly'].map((hourly) => HourlyWeather.fromJson(hourly)).toList(),
    ),
    daily: List<DailyWeather>.from(
      json['daily'].map((daily) => DailyWeather.fromJson(daily)).toList(),
    ),
  );
}
