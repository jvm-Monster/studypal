import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/util/alarm_setter.dart';

import '../app_states/schedule_lists_notifier.dart';
import '../models/schedule_task.dart';

class SubmitScheduledTaskUtil {
  static Future<int> submitTask(
      String value,
      String selectedDay,
      remindMeAt,
      WidgetRef ref,
      scheduleId,
      String description,
      String lead,
      String day) async {
    String h = remindMeAt.hour.toString().padLeft(2, '0');
    String m = remindMeAt.minute.toString().padLeft(2, '0');
    String dueDate = '$h:$m ${remindMeAt.period == DayPeriod.am ? "AM" : "PM"}';

    // there used to be a daysSelectedForTheCourse which has a datatype of List<String> and is being replaced by day
    ScheduleTask scheduleTask = ScheduleTask(
        name: value,
        day: day,
        description: description,
        lead: lead,
        dueDate: dueDate,
        scheduleId: scheduleId,
        completed: 0);
    int id = await ref
        .refresh(scheduleListNotifierProvider.notifier)
        .insertTaskForSchedule(scheduleTask);
    return id;
  }

  static deleteTask(ref, int scheduleTaskId) {
    AlarmSetter.cancelAlarm(id: scheduleTaskId);
    ref
        .read(scheduleListNotifierProvider.notifier)
        .deleteTaskForSchedule(scheduleTaskId);
  }
}
