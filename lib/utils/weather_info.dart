import 'package:natife_weather/gen/assets.gen.dart';

class WeatherInfo {
  final Map<String, String> iconMap = {
    'Clear01d': Assets.images.vector.whiteDayBright.path,
    'Clouds02d': Assets.images.vector.whiteDayCloudy.path,
    'Clouds03d': Assets.images.vector.whiteScatteredClouds.path,
    'Clouds04d': Assets.images.vector.whiteBrokenClouds.path,
    'Drizzle09d': Assets.images.vector.whiteDayShower.path,
    'Rain09d': Assets.images.vector.whiteDayShower.path,
    'Rain10d': Assets.images.vector.whiteDayRain.path,
    'Rain13d': Assets.images.vector.snow.path,
    'Thunderstorm11d': Assets.images.vector.whiteDayThunder.path,
    'Snow13d':Assets.images.vector.snow.path,
    'Mist50d': Assets.images.vector.mist.path,
    'Smoke50d': Assets.images.vector.mist.path,
    'Haze50d': Assets.images.vector.mist.path,
    'Dust50d': Assets.images.vector.mist.path,
    'Fog50d': Assets.images.vector.mist.path,
    'Sand50d': Assets.images.vector.mist.path,
    'Ash50d': Assets.images.vector.mist.path,
    'Squall50d': Assets.images.vector.mist.path,
    'Tornado50d': Assets.images.vector.mist.path,

    'Clear01n': Assets.images.vector.whiteNightBright.path,
    'Clouds02n': Assets.images.vector.whiteNightCloudy.path,
    'Clouds03n': Assets.images.vector.whiteScatteredClouds.path,
    'Clouds04n': Assets.images.vector.whiteBrokenClouds.path,
    'Drizzle09n': Assets.images.vector.whiteNightShower.path,
    'Rain09n': Assets.images.vector.whiteNightShower.path,
    'Rain10n': Assets.images.vector.whiteNightRain.path,
    'Rain13n': Assets.images.vector.snow.path,
    'Thunderstorm11n': Assets.images.vector.whiteNightThunder.path,
    'Snow13n':Assets.images.vector.snow.path,
    'Mist50n': Assets.images.vector.mist.path,
    'Smoke50n': Assets.images.vector.mist.path,
    'Haze50n': Assets.images.vector.mist.path,
    'Dust50n': Assets.images.vector.mist.path,
    'Fog50n': Assets.images.vector.mist.path,
    'Sand50n': Assets.images.vector.mist.path,
    'Ash50n': Assets.images.vector.mist.path,
    'Squall50n': Assets.images.vector.mist.path,
    'Tornado50n': Assets.images.vector.mist.path,
  };

  String combinedIconName(String main, String icon) {
    final words = main.split(' ');
    final capitalizedWords = words.map((word) {
      if (words.first != word) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return word;
      }
    });
    final sanitizedDescription = capitalizedWords.join();
    return '$sanitizedDescription$icon';
  }

  static String getWeatherIcon(String main, String icon) {
    final weatherInfo = WeatherInfo();
    final iconName = weatherInfo.combinedIconName(main, icon);
    final iconPath = weatherInfo.iconMap[iconName];

    if (iconPath != null && weatherInfo.iconMap.containsKey(iconName)) {
      return iconPath;
    } else {
      return Assets.images.vector.disconnected.path;
    }
  }
}
