

import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  // Use intl package to format the time in 12-hour format
  final formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}