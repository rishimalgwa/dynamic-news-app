import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDateTimehmma(int secondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
    DateFormat dateFormat = DateFormat('h:mm a'); // Format to `10:00 AM`
    return dateFormat.format(dateTime);
  }

  static String formatRemainingTimehmma(int secondsSinceEpoch) {
    DateTime tripDateTime =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
    Duration difference = tripDateTime.difference(DateTime.now());

    if (difference.isNegative) {
      Duration delay =
          difference.abs(); // Get the absolute value of the difference
      int hours = delay.inHours;
      int minutes = delay.inMinutes.remainder(60);
      return '${hours}h ${minutes}min';
    }

    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    return '${hours}h ${minutes}min';
  }

  static String formatDateTimeyMMEd(int secondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
    DateFormat dateFormat = DateFormat.yMMMEd();
    return dateFormat.format(dateTime);
  }
}
