import 'package:flutter/material.dart';
import 'package:studypal/util/days_of_the_week.dart';

import '../service/notification_service.dart';
 

class AlarmSetter {
  final String selectedDay;
  final TimeOfDay timeOfDay;

  AlarmSetter({required this.selectedDay, required this.timeOfDay});

  DateTime _prepareDateAndTime() {
    DateTime now = DateTime.now();
    int selectedDayPositionInTheWeek = DaysOfTheWeek.parseDayOfWeek(
        selectedDay); //basically gives the position or number of the day in the week
    // Calculate the scheduled date for the alarm based on the selected day and time
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + (selectedDayPositionInTheWeek - now.weekday + 7) % 7,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    return scheduledDate;
  }

  void setAlarm({required id, required title, required body}) async {
    await NotificationService().scheduleNotification(
        id: id, title: title, body: body, scheduledDate: _prepareDateAndTime());
  }

  static cancelAlarm({required int id}) {
    NotificationService.cancelNotification(id);
  }
}
