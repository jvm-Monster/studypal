import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CreateAlarm{
  String text;
  TimeOfDay timeOfDay;
  var context;

  CreateAlarm({required this.text,required this.timeOfDay,required this.context});


  void createAlarmForTask() {
    // Get the current date
    DateTime now = DateTime.now();

    // Get the selected time from TimeOfDay
    int hour = timeOfDay.hour;
    int minute = timeOfDay.minute;


    // Calculate the scheduled time for the alarm
    DateTime scheduledTime = DateTime(
        now.year, now.month, now.day, hour, minute);

    // Create the notification
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: "studypal_channel",
        title: text,
        wakeUpScreen: true,
        body: timeOfDay.format(context),
        // Replace with the actual body text
        category: NotificationCategory.Alarm,
        customSound: "resource://raw/res_sound.m4a"
      ),
      actionButtons: [
        NotificationActionButton(
          key: "open_settings",
          label: "Open Settings",
          /* actionType: ActionType.Default,
        autoDismissible: true, */
        ),
      ],
      schedule: NotificationCalendar(
        weekday: scheduledTime.weekday,
        hour: scheduledTime.hour,
        minute: scheduledTime.minute,
        second: 0,
        millisecond: 0,
        repeats: true
      ),
    );
  }

}