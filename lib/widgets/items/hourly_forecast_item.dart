import 'package:flutter/material.dart';
import 'package:natife_weather/gen/fonts.gen.dart';
import 'package:natife_weather/gen/colors.gen.dart';
import 'package:natife_weather/widgets/images/svg_image.dart';
import 'package:natife_weather/widgets/skeletons/skeleton_view.dart';
import 'package:natife_weather/models/weather/weather_forecast.dart';

class HourlyForecastItem extends StatelessWidget {
  final String timeLabel;
  final String assetImage;
  final String temperatureLabel;
  final WeatherForecast? weather;

  const HourlyForecastItem(
      {Key? key,
      required this.timeLabel,
      required this.assetImage,
      required this.temperatureLabel,
      required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: ColorName.skyBlue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          weather != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeLabel.substring(0, 2),
                      style: const TextStyle(
                          color: ColorName.light,
                          height: 0.9,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.sFProDisplay),
                    ),
                    Text(
                      timeLabel.substring(2).replaceAll(':', ' '),
                      style: const TextStyle(
                          color: ColorName.light,
                          height: 0.9,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.sFProDisplay),
                    )
                  ],
                )
              : const SkeletonView(width: 60, height: 20, radius: 4),
          const SizedBox(height: 20),
          weather != null
              ? SvgImage(asset: assetImage, color: ColorName.light, size: 40)
              : const SkeletonView(width: 40, height: 40, radius: 6),
          SizedBox(height: weather != null ? 0 : 10),
          weather != null
              ? Text(
                  temperatureLabel,
                  style: const TextStyle(
                      color: ColorName.light,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.sFProDisplay),
                )
              : const SkeletonView(width: 30, height: 24, radius: 4),
        ],
      ),
    );
  }
}
