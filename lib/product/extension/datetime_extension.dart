// ignore_for_file: unnecessary_this

import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String toTimeAgoLabel({bool numericIntervals = false}) {
    final DateTime now = DateTime.now();
    final Duration durationSinceNow = now.difference(this);

    final int inDays = durationSinceNow.inDays;
    if (inDays >= 1) {
      if ((inDays / 7).floor() >= 1) {
        return numericIntervals ? '1 week ago' : 'Last week';
      } else if (inDays >= 2) {
        return '$inDays days ago';
      } else {
        return numericIntervals ? '1 day ago' : 'Yesterday';
      }
    }

    final int inHours = durationSinceNow.inHours;
    if (inHours >= 1) {
      if (inHours >= 2) {
        return '$inHours hours ago';
      } else {
        return numericIntervals ? '1 hour ago' : 'An hour ago';
      }
    }

    final int inMinutes = durationSinceNow.inMinutes;
    if (inMinutes >= 1) {
      if (inMinutes >= 2) {
        return '$inMinutes minutes ago';
      } else {
        return numericIntervals ? '1 minute ago' : 'A minute ago';
      }
    }

    final int inSeconds = durationSinceNow.inSeconds;
    return inSeconds >= 3 ? '$inSeconds seconds ago' : 'Just now';
  }

  String toTimeToGoLabel({bool numericIntervals = false}) {
    final DateTime now = DateTime.now();
    final Duration durationToNow = this.difference(now);

    final int inDays = durationToNow.inDays;
    if (inDays >= 1) {
      if ((inDays / 7).floor() >= 1) {
        return numericIntervals ? 'In 1 week' : 'Next week';
      } else if (inDays >= 2) {
        return 'In $inDays days';
      } else {
        return numericIntervals ? 'In 1 day' : 'Tomorrow';
      }
    }

    final int inHours = durationToNow.inHours;
    if (inHours >= 1) {
      if (inHours >= 2) {
        return 'In $inHours hours';
      } else {
        return numericIntervals ? 'In 1 hour' : 'In an hour';
      }
    }

    final int inMinutes = durationToNow.inMinutes;
    if (inMinutes >= 1) {
      if (inMinutes >= 2) {
        return 'In $inMinutes minutes';
      } else {
        return numericIntervals ? 'In 1 minute' : 'In a minute';
      }
    }

    final int inSeconds = durationToNow.inSeconds;
    return inSeconds >= 3 ? 'In $inSeconds seconds' : 'Just about now';
  }

  String toDateString([String format = 'd MMM, y - hh:mm a']) {
    return DateFormat(format).format(this);
  }
}
