import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/util/alarm_setter.dart';
import 'package:studypal/widgets/add_course_status_snackbar.dart';

import '../models/course.dart';
import '../util/submit_scheduled_task_util.dart';
import '../widgets/checkbox_day_list.dart';

class SelectCourseDayScreen extends ConsumerStatefulWidget {
  final Course course;

  const SelectCourseDayScreen({super.key, required this.course});

  @override
  ConsumerState createState() => _SelectCourseDayScreenState();
}

class _SelectCourseDayScreenState extends ConsumerState<SelectCourseDayScreen> {
  @override
  Widget build(BuildContext context) {
    final watchCheckBoxAlarmProvider = ref.watch(checkBoxAlarmProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Days for this course?',
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await _saveCourse(watchCheckBoxAlarmProvider);
                _showScaffoldMessage();
                _popUpScreen();
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: const CheckBoxDayList(),
    );
  }

  Future<void> _saveCourse(Map<String, TimeOfDay> a) async {
    a.forEach((selectedDay, time) async {
      int? id = await SubmitScheduledTaskUtil.submitTask(
          widget.course.title,
          widget.course.selectedDay,
          time,
          ref,
          widget.course.scheduleId,
          widget.course.description,
          widget.course.lead,
          selectedDay);

      // Set the alarm for the selected day and time
      AlarmSetter alarm = AlarmSetter(
        selectedDay: selectedDay,
        timeOfDay: time,
      );
      alarm.setAlarm(
        id: id,
        title: widget.course.title,
        body: widget.course.description,
      );
    });
  }

  _showScaffoldMessage() {
    ScaffoldMessenger.of(context).showSnackBar(const AddCourseStatusSnackBar(
        content: Text("Course added successfully..")));
  }

  _popUpScreen() {
    Navigator.pop(context);
  }
}
