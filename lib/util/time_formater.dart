import 'package:flutter/material.dart';

/// A class used for formating time eg using 12 hours time
class TimeFormatter {
  /// takes in 2 parameters timeOfDay and context
  static String formatTime(TimeOfDay? timeOfDay, context) {
    if (timeOfDay == null) {
      return "";
    }
    return timeOfDay.format(context);
  }
}
