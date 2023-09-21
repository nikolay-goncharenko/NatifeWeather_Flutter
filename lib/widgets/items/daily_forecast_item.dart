import 'package:flutter/material.dart';
import 'package:natife_weather/gen/fonts.gen.dart';
import 'package:natife_weather/gen/colors.gen.dart';
import 'package:natife_weather/widgets/images/svg_image.dart';
import 'package:natife_weather/widgets/skeletons/skeleton_view.dart';
import 'package:natife_weather/models/weather/weather_forecast.dart';

class DailyForecastItem extends StatelessWidget {
  final String dayLabel;
  final String temperatureLabel;
  final String assetImage;
  final WeatherForecast? weather;
  final bool isDateToday;

  const DailyForecastItem(
      {Key? key,
      required this.dayLabel,
      required this.temperatureLabel,
      required this.assetImage,
      required this.weather,
      required this.isDateToday})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: ColorName.light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          weather != null
              ? Container(
                  constraints: const BoxConstraints(minWidth: 50),
                  child: Text(
                    dayLabel,
                    style: TextStyle(
                        color: isDateToday ? ColorName.blue : Colors.black,
                        fontSize: 22,
                        fontWeight:
                            isDateToday ? FontWeight.w700 : FontWeight.w500,
                        fontFamily: FontFamily.sFProDisplay),
                  ),
                )
              : const SkeletonView(width: 60, height: 24, radius: 4),
          weather != null
              ? Text(
                  temperatureLabel,
                  style: TextStyle(
                      color: isDateToday ? ColorName.blue : Colors.black,
                      fontSize: 22,
                      fontWeight:
                          isDateToday ? FontWeight.w700 : FontWeight.w500,
                      fontFamily: FontFamily.sFProDisplay),
                )
              : const SkeletonView(width: 80, height: 24, radius: 4),
          weather != null
              ? SvgImage(
                  asset: assetImage,
                  color: isDateToday ? ColorName.blue : Colors.black,
                  size: 40)
              : const SkeletonView(width: 40, height: 40, radius: 6),
        ],
      ),
    );
  }
}
