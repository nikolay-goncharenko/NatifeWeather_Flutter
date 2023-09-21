// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:natife_weather/models/location_data.dart';
import 'package:natife_weather/models/weather/blocking_error.dart';
import 'package:natife_weather/models/weather/weather_forecast.dart';

class NetworkManager {
  static Future<dynamic> loadWeather(String lat, String long) async {
    try {
      final baseUrl =
          Uri.parse('https://api.openweathermap.org/data/2.5/onecall');

      final url = baseUrl.replace(queryParameters: {
        'lat': lat,
        'lon': long,
        'units': 'metric',
        'exclude': 'minutely',
        'appid': 'ec7a71a0b86c79eb2f01a230ac62e06f'
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final WeatherForecast forecast = WeatherForecast.fromJson(jsonData);
        return forecast;
      } else {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final BlockingError blockingError = BlockingError.fromJson(jsonData);
        return blockingError;
      }
    } catch (e) {
      print('Failed to load data: $e');
      throw Exception('Failed to load data');
    }
  }

  static Future<List<LocationData>> findLocation(String q) async {
    try {
      final baseUrl =
          Uri.parse('https://api.openweathermap.org/geo/1.0/direct');

      final url = baseUrl.replace(queryParameters: {
        'q': q,
        'limit': '5',
        'appid': 'ec7a71a0b86c79eb2f01a230ac62e06f',
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final List<LocationData> locations = jsonData.map((item) {
          return LocationData.fromJson(item);
        }).toList();
        return locations;
      } else {
        print('Request failed with status: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Failed to load data: $e');
      throw Exception('Failed to load data');
    }
  }
}
