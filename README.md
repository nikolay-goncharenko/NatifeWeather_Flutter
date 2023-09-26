<img src="screenshots/cover.png" align="center">

![Natife_Weather](https://img.shields.io/badge/Natife_Weather-v0.1.0-orange) ![badge-ios](http://img.shields.io/badge/Platform-iOS-silver.svg?logo=apple) ![badge-android](http://img.shields.io/badge/Platform-Android-brightgreen.svg?logo=android) ![Dart](https://img.shields.io/badge/Dart-v3.1.0-blue) ![Flutter](https://img.shields.io/badge/Flutter-v3.13.0-blue) [![RESTful API](https://img.shields.io/badge/RESTful_API-OpenWeatherMap_API-brightgreen.svg)](https://openweathermap.org/api) ![GitHub last commit](https://img.shields.io/github/last-commit/nikolay-goncharenko/NatifeWeather_Flutter) ![GitHub repo size](https://img.shields.io/github/repo-size/nikolay-goncharenko/NatifeWeather_Flutter)

# Natife Weather - weather app

This is a demo application to view weather forecast for today, the next 48 hours and a week ahead. The application is developed using Flutter framework and uses data from [OpenWeatherMap API](https://openweathermap.org/api).

<img src="screenshots/app_design.png" align="center">

## Demo

|iOS|android|
|:------------:|:------------:|
| <video src="screenshots/natife_weather_iOS.mp4"> | <video src="screenshots/natife_weather_android.mp4"> |
## Features

- View current weather with maximum and minimum temperature, average humidity, wind speed and direction.
- Detailed forecast for the next 48 hours with hourly temperature information.
- Week ahead weather forecast including maximum and minimum temperatures for each day.
- Possibility to search for settlements with autocompletion by keyboard input.
- Selecting a settlement and then downloading the weather to the main screen.

## Packages involved in the project

|Packages|Description|
|--|--|
|[![Flutter_Svg](https://img.shields.io/badge/Flutter_SVG-v2.0.7-blue)](https://pub.dev/packages/flutter_svg)|For working with vector images. Draw SVG files using Flutter.|
|[![HTTP](https://img.shields.io/badge/HTTP-v1.1.0-blue)](https://pub.dev/packages/http)|A composable, Future-based library for making HTTP requests. This package contains a set of high-level functions and classes that make it easy to consume HTTP resources. It's multi-platform, and supports mobile, desktop, and the browser.|
|[![Shimmer](https://img.shields.io/badge/Shimmer-v3.0.0-blue)](https://pub.dev/packages/shimmer)|A package provides an easy way to add shimmer effect in Flutter project.|
|[![intl](https://img.shields.io/badge/intl-v0.18.1-blue)](https://pub.dev/packages/intl)|Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.|
|[![geolocator](https://img.shields.io/badge/geolocator-v10.0.1-blue)](https://pub.dev/packages/geolocator)|A Flutter geolocation plugin which provides easy access to platform specific location services ([FusedLocationProviderClient](https://developers.google.com/android/reference/com/google/android/gms/location/FusedLocationProviderClient) or if not available the [LocationManager](https://developer.android.com/reference/android/location/LocationManager) on Android and [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager) on iOS).|
|[![geocoding](https://img.shields.io/badge/geocoding-v2.1.0-blue)](https://pub.dev/packages/geocoding)|A Flutter Geocoding plugin which provides easy geocoding and reverse-geocoding features.|
|[![Fluttertoast](https://img.shields.io/badge/Fluttertoast-v8.2.2-blue)](https://pub.dev/packages/fluttertoast)|Toast library for Flutter - simple toast messages.|
|[![Flutter_App_Renamer](https://img.shields.io/badge/Flutter_App_Renamer-v1.0.3-blue)](https://pub.dev/packages/flutter_app_renamer)|A command-line tool that makes it easy to change your project's AppName and BundleID by defining them in your pubspec.yaml file.|
|[![Flutter_Launcher_Icons](https://img.shields.io/badge/Flutter_Launcher_Icons-v0.11.0-blue)](https://pub.dev/packages/flutter_launcher_icons)|A command-line tool which simplifies the task of updating your Flutter app's launcher icon. Fully flexible, allowing you to choose what platform you wish to update the launcher icon for and if you want, the option to keep your old launcher icon in case you want to revert back sometime in the future.|
|[![Flutter_Gen](https://img.shields.io/badge/Flutter_Gen-v5.3.1-blue)](https://pub.dev/packages/flutter_gen)|The Flutter code generator for your assets, fonts, colors, … — Get rid of all String-based APIs.|
|[![Build_Runner](https://img.shields.io/badge/Build_Runner-v2.4.6-blue)](https://pub.dev/packages/build_runner)|As a part of FlutterGen. The `build_runner` package provides a concrete way of generating files using Dart code. Files are always generated directly on disk, and rebuilds are _incremental._|

## API Usage

|Endpoints|Description|
|--|--|
|[![One_Call_API_2.5](https://img.shields.io/badge/One_Call_API_2.5-Current_and_forecast_weather_data-orange.svg)](https://openweathermap.org/api/one-call-api)|Make just one API call and get all your essential weather data for a specific location with an OpenWeather **One Call API 2.5**. The One Call API 2.5 provides the following weather data for any geographical coordinates: <br> - Current weather <br> - Hourly forecast for 48 hours <br> - Daily forecast for 7 days|      
|[![Geocoding API](https://img.shields.io/badge/Geocoding_API-Coordinates_by_location_name-orange.svg)](https://openweathermap.org/api/geocoding-api)|Direct geocoding allows to get geographical coordinates (lat, lon) by using name of the location (city name or area name). If you use the `limit` parameter in the API call, you can cap how many locations with the same name will be seen in the API response (for instance, London in the UK and London in the US).|
