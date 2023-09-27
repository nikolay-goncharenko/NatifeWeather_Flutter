import 'package:natife_weather/gen/assets.gen.dart';

class Range {
  final double min;
  final double max;

  const Range(this.min, this.max);
}

class WindInfo {
  String getWindDirectionIcon(WindDirection direction) {
    switch (direction) {
      case WindDirection.north:
        return Assets.images.vector.windN.path;
      case WindDirection.south:
        return Assets.images.vector.windS.path;
      case WindDirection.east:
        return Assets.images.vector.windE.path;
      case WindDirection.west:
        return Assets.images.vector.windW.path;
      case WindDirection.northEast:
        return Assets.images.vector.windNe.path;
      case WindDirection.northWest:
        return Assets.images.vector.windWn.path;
      case WindDirection.southEast:
        return Assets.images.vector.windSe.path;
      case WindDirection.southWest:
        return Assets.images.vector.windWs.path;
      default:
        return Assets.images.vector.disconnected.path;
    }
  }

  static String getWindDirectionIconByDegree(int degree) {
    WindDirection result = WindDirection.disconnected;
    final windInfo = WindInfo();

    for (var direction in WindDirection.values) {
      final degreeRange = direction.getDegreeRange();

      if ((degree >= degreeRange.min && degree < degreeRange.max) ||
          (degree >= degreeRange.min + 360 && degree < degreeRange.max + 360)) {
        result = direction;
        break;
      }
    }

    return windInfo.getWindDirectionIcon(result);
  }
}

enum WindDirection {
  disconnected,
  north,
  south,
  east,
  west,
  northEast,
  northWest,
  southEast,
  southWest,
}

extension WindDirectionExtension on WindDirection {
  Range getDegreeRange() {
    switch (this) {
      case WindDirection.north:
        return const Range(337.5, 22.5);
      case WindDirection.northEast:
        return const Range(22.5, 67.5);
      case WindDirection.east:
        return const Range(67.5, 112.5);
      case WindDirection.southEast:
        return const Range(112.5, 157.5);
      case WindDirection.south:
        return const Range(157.5, 202.5);
      case WindDirection.southWest:
        return const Range(202.5, 247.5);
      case WindDirection.west:
        return const Range(247.5, 292.5);
      case WindDirection.northWest:
        return const Range(292.5, 337.5);
      case WindDirection.disconnected:
        return const Range(0, 0);
    }
  }
}
