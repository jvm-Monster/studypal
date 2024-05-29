import 'package:flutter/material.dart';

class AppTimePicker {
  static Future<TimeOfDay?> setTime(context, {required String textMessage}) {
    return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.inputOnly,
      helpText: textMessage,
      initialTime: TimeOfDay.now(),
      useRootNavigator: false,
      // Add this line
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
  }
}
