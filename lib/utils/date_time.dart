import 'package:intl/intl.dart';

class DateTimeUtils {
  static bool isDateToday(int timestamp) {
      final todayDateString = DateFormat('E, d MMMM').format(DateTime.now());
      final dailyDateString = DateTimeUtils.timestampToDate(timestamp);
      return todayDateString == dailyDateString;
  }

  static String? timestampToDate(int? timestamp) {
    if (timestamp != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final formattedDate = DateFormat('E, d MMMM').format(dateTime);
      return formattedDate;
    } else {
      return null;
    }
  }

  static String? timestampToTime(int? timestamp) {
    if (timestamp != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final formattedTime = DateFormat.Hm().format(dateTime);
      return formattedTime;
    } else {
      return null;
    }
  }

  static String? timestampToDayOfWeek(int? timestamp) {
    if (timestamp != null) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      final formattedDayOfWeek = DateFormat.E().format(dateTime);
      return formattedDayOfWeek;
    } else {
      return null;
    }
  }
}
