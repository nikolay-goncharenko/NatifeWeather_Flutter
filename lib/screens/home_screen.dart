import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:natife_weather/gen/fonts.gen.dart';
import 'package:natife_weather/gen/assets.gen.dart';
import 'package:natife_weather/gen/colors.gen.dart';
import 'package:natife_weather/utils/date_time.dart';
import 'package:natife_weather/utils/wind_info.dart';
import 'package:natife_weather/widgets/images/svg_image.dart';
import 'package:natife_weather/utils/weather_info.dart';
import 'package:natife_weather/models/geolocation_data.dart';
import 'package:natife_weather/network/network_manager.dart';
import 'package:natife_weather/screens/location_screen.dart';
import 'package:natife_weather/models/weather/blocking_error.dart';
import 'package:natife_weather/widgets/skeletons/skeleton_view.dart';
import 'package:natife_weather/models/weather/weather_forecast.dart';
import 'package:natife_weather/widgets/buttons/plane_image_button.dart';
import 'package:natife_weather/widgets/items/hourly_forecast_item.dart';
import 'package:natife_weather/widgets/items/daily_forecast_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  GeolocationData? geolocationData;
  WeatherForecast? weather;
  BlockingError? blockingError;
  Timer? _timer;
  double? alpha;

  @override
  void initState() {
    super.initState();
    getLocationAndCityName().then((_) => fetchWeatherData());

    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchWeatherData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.blue, // Status bar color
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: ColorName.blue,
          body: Column(
            children: <Widget>[
              Container(
                height: 250,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    /// Row with top buttons
                    buttonsHorizontalStack(context),
                    const SizedBox(height: 10),

                    /// Date Label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        weather != null
                            ? Text(
                                DateTimeUtils.timestampToDate(
                                        weather?.current.dt) ??
                                    "Error loading date",
                                style: const TextStyle(
                                    color: ColorName.light,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: FontFamily.sFProDisplay),
                              )
                            : const SkeletonView(
                                width: 150, height: 16, radius: 3)
                      ],
                    ),
                    const SizedBox(height: 10),

                    /// Big Weather Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        weather != null
                            ? SvgImage(
                                asset: WeatherInfo.getWeatherIcon(
                                  weather?.current.weatherIcons.first.main ??
                                      'Error',
                                  weather?.current.weatherIcons.first.icon ??
                                      'Error',
                                ),
                                color: ColorName.light,
                                size: 160)
                            : const SkeletonView(
                                width: 150, height: 150, radius: 10),
                        const SizedBox(width: 20),
                        weatherIndicatorsView()
                      ],
                    ),
                  ],
                ),
              ),

              /// Horizontal ListView
              horizontalListView(),

              /// Vertical ListView
              verticalListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonsHorizontalStack(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTapDown: (_) => setState(() => alpha = 0.6),
            onTapUp: (_) => setState(() => alpha = 0.6),
            onTapCancel: () => setState(() => alpha = 1.0),
            child: Opacity(
              opacity: alpha ?? 1.0,
              child: TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(0)),
                  ),
                  onPressed: () => openLocationScreen(context),
                  icon: geolocationData?.cityName != null
                      ? SvgImage(
                          asset: Assets.images.vector.place.path,
                          color: ColorName.light,
                          size: 20)
                      : const SkeletonView(width: 25, height: 25, radius: 5),
                  label: geolocationData?.cityName != null
                      ? Text(
                          geolocationData?.cityName ?? "Error",
                          style: const TextStyle(
                            color: ColorName.light,
                            fontSize: 25,
                            fontFamily: FontFamily.sFProDisplay,
                          ),
                        )
                      : const SkeletonView(width: 130, height: 25, radius: 5)),
            ),
          ),
          geolocationData?.cityName != null
              ? PlaneImageButton(
                  size: 45,
                  assetImage: Assets.images.vector.location.path,
                  onPressedCallback: () =>
                      getLocationAndCityName().then((_) => fetchWeatherData()),
                )
              : const SkeletonView(width: 25, height: 25, radius: 5)
        ],
      );

  Widget weatherIndicatorsView() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: weather != null ? 3 : 0),
              weather != null
                  ? SvgImage(
                      asset: Assets.images.vector.temp.path,
                      color: ColorName.light,
                      size: 22)
                  : const SkeletonView(width: 22, height: 22, radius: 4),
              SizedBox(width: weather != null ? 14 : 10),
              weather != null
                  ? Text(
                      weather != null
                          ? "${weather?.current.temperature.round()}°"
                          : "Error",
                      style: const TextStyle(
                          color: ColorName.light,
                          fontSize: 24,
                          fontFamily: FontFamily.sFProDisplay),
                    )
                  : const SkeletonView(width: 40, height: 22, radius: 4),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              weather != null
                  ? SvgImage(
                      asset: Assets.images.vector.humidity.path,
                      color: ColorName.light,
                      size: 22)
                  : const SkeletonView(width: 22, height: 22, radius: 4),
              const SizedBox(width: 10),
              weather != null
                  ? Text(
                      weather != null
                          ? "${weather?.current.humidity}%"
                          : "Error",
                      style: const TextStyle(
                          color: ColorName.light,
                          fontSize: 24,
                          fontFamily: FontFamily.sFProDisplay),
                    )
                  : const SkeletonView(width: 60, height: 22, radius: 4),
            ],
          ),
          SizedBox(height: weather != null ? 10 : 12),
          Row(
            children: <Widget>[
              weather != null
                  ? SvgImage(
                      asset: Assets.images.vector.wind.path,
                      color: ColorName.light,
                      size: 22)
                  : const SkeletonView(width: 22, height: 22, radius: 4),
              const SizedBox(width: 10),
              weather != null
                  ? Text(
                      weather != null
                          ? "${weather?.current.windSpeed.round()}m/sec "
                          : "Error",
                      style: const TextStyle(
                          color: ColorName.light,
                          fontSize: 24,
                          fontFamily: FontFamily.sFProDisplay),
                    )
                  : const SkeletonView(width: 90, height: 22, radius: 4),
              weather != null
                  ? const SizedBox(width: 0)
                  : const SizedBox(width: 10),
              weather != null
                  ? SvgImage(
                      asset: WindInfo.getWindDirectionIconByDegree(
                          weather?.current.windDeg ?? 0),
                      color: ColorName.light,
                      size: weather != null ? 35 : 24)
                  : const SkeletonView(width: 22, height: 22, radius: 4),
            ],
          ),
        ],
      );

  Widget horizontalListView() => Container(
        height: 150,
        color: ColorName.skyBlue,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: weather?.hourly.length,
            itemBuilder: (BuildContext context, int index) {
              return HourlyForecastItem(
                timeLabel:
                    DateTimeUtils.timestampToTime(weather?.hourly[index].dt) ??
                        "Error",
                assetImage: WeatherInfo.getWeatherIcon(
                  weather?.hourly[index].weatherIcons.first.main ?? 'Error',
                  weather?.hourly[index].weatherIcons.first.icon ?? 'Error',
                ),
                temperatureLabel: weather != null
                    ? "${weather?.hourly[index].temperature.round()}°"
                    : "Error",
                weather: weather,
              );
            }),
      );

  Widget verticalListView() => Expanded(
        child: Container(
          color: ColorName.light,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: weather?.daily.length,
              itemBuilder: (BuildContext context, int index) {
                return DailyForecastItem(
                  dayLabel: DateTimeUtils.timestampToDayOfWeek(
                          weather?.daily[index].dt) ??
                      "Error",
                  temperatureLabel: weather != null
                      ? "${weather?.daily[index].temperature.min.round()}° / ${weather?.daily[index].temperature.max.round()}°"
                      : "Error",
                  assetImage: WeatherInfo.getWeatherIcon(
                    weather?.hourly[index].weatherIcons.first.main ?? 'Error',
                    weather?.hourly[index].weatherIcons.first.icon ?? 'Error',
                  ),
                  weather: weather,
                  isDateToday:
                      DateTimeUtils.isDateToday(weather?.daily[index].dt ?? 0),
                );
              }),
        ),
      );

  Future<void> fetchWeatherData() async {
    final weather = await NetworkManager.loadWeather(
      geolocationData!.latitude,
      geolocationData!.longitude,
    );

    setState(() {
      if (weather is WeatherForecast) {
        this.weather = WeatherForecast(
          latitude: weather.latitude,
          longitude: weather.longitude,
          current: weather.current,
          hourly: weather.hourly,
          daily: weather.daily,
        );
      } else if (weather is BlockingError) {
        blockingError = BlockingError(
          cod: weather.cod,
          message: weather.message,
        );
      }
    });
  }

  void openLocationScreen(BuildContext context) async {
    final updatedLocationData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LocationScreen()),
    );
    if (updatedLocationData != null) {
      setState(() => geolocationData = updatedLocationData);
      fetchWeatherData();
    }
  }

  Future<void> getLocationAndCityName() async {
    try {
      final LocationPermission permission =
          await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied");
      } else if (permission == LocationPermission.whileInUse) {
        // Fluttertoast.showToast(msg: "Location permission granted (while in use)");
      } else if (permission == LocationPermission.always) {
        Fluttertoast.showToast(msg: "Location permission granted (forever)");
      } else {
        Fluttertoast.showToast(msg: "Location permission unknown");
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        final cityName = placemark.locality ?? 'Unknown City';
        setState(() {
          geolocationData = GeolocationData(
            cityName: cityName,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
          );
        });
      } else {
        Fluttertoast.showToast(msg: 'City not found');
        // return LocationData(city: 'City not found', lat: '0', lon: '0');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error getting location: $e');
      // return LocationData(city: 'Error getting location', lat: '0', lon: '0');
    }
  }
}
