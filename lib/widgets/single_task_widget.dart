import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/util/days_of_the_week.dart';
import 'package:studypal/util/time_formater.dart';
import 'package:studypal/widgets/random_color_picker.dart';

import '../app_states/schedule_lists_notifier.dart';
import '../models/schedule_task.dart';
import '../service/notification_service.dart';
 
import 'add_course_status_snackbar.dart';

class SingleTaskWidget extends ConsumerStatefulWidget {
  final ScheduleTask scheduleTask;
  final int scheduleTaskIndex;

  const SingleTaskWidget(
      {super.key, required this.scheduleTask, required this.scheduleTaskIndex});

  @override
  ConsumerState createState() => _SingleTaskWidgetState();
}

/* Color(
                    0xCFE4E1E1))*/
class _SingleTaskWidgetState extends ConsumerState<SingleTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(widget.scheduleTask.name,
                          style: const TextStyle(
                            fontSize: 20,
                          )),
                    ),

                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                widget.scheduleTask.description!.isNotEmpty?Text(widget.scheduleTask.description!):Container(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Row(
                        children: [
                          const Text(
                            "Lecturer: ",
                          ),
                          Text(
                            widget.scheduleTask.lead ?? "",
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          List timeOfDayAndFormatedTimeString = await _timePicker();

                          if (timeOfDayAndFormatedTimeString.isNotEmpty) {
                            String time = timeOfDayAndFormatedTimeString[1];
                            bool success = await ref
                                .read(scheduleListNotifierProvider.notifier)
                                .updateTaskForSchedule(
                                scheduleId: widget.scheduleTask.scheduleId,
                                taskId: widget.scheduleTask.id!,
                                day: widget.scheduleTask.day,
                                name: widget.scheduleTask.name,
                                time: time);

                            if (success) {}

                            DateTime dateTime = DateTime.now();
                            TimeOfDay timeOfDay = timeOfDayAndFormatedTimeString[0];
                            await NotificationService().scheduleNotification(
                                id: widget.scheduleTask.id!,
                                scheduledDate: DateTime(
                                    dateTime.year,
                                    dateTime.month,
                                    DaysOfTheWeek.parseDayOfWeek(
                                        widget.scheduleTask.day),
                                    timeOfDay.hour,
                                    timeOfDay.minute),
                                title: widget.scheduleTask.name,
                                body: widget.scheduleTask.description);
                          }

                        },
                        child: Text(
                          widget.scheduleTask.dueDate,
                          style: const TextStyle(fontSize: 10),
                        )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RandomColorPicker(
                scheduleTaskIndex: widget.scheduleTaskIndex,
              )),
        ],
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    return TimeFormatter.formatTime(time, context);
  }

  Future<List> _timePicker() async {
    List timeList = [];
    try {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialEntryMode: TimePickerEntryMode.inputOnly,
        helpText: 'Change time for this course',
        initialTime: TimeOfDay.now(),
        useRootNavigator: false,
        //i don't about this just added it
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!);
        },
      );
      String formatedTime = _formatTime(time!);
      timeList.add(time);
      timeList.add(formatedTime);
      return timeList;
    } catch (e) {
      return [];
    }
  }

  int getDayIndex(String day, List<String> listOfDaysSelected) {
    for (int i = 0; i < listOfDaysSelected.length; i++) {
      if (day == listOfDaysSelected[i]) {
        return i;
      }
    }
    return -1;
  }

  _showScaffoldMessage() {
    ScaffoldMessenger.of(context).showSnackBar(const AddCourseStatusSnackBar(
        content: Text(
      "Course time for this day changed",
      style: TextStyle(color: Colors.green),
    )));
  }
}
