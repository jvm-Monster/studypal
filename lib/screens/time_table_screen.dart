import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/schedule_lists_notifier.dart';
import 'package:studypal/models/schedule.dart';
import 'package:studypal/screens/add_a_new_course.dart';
import 'package:studypal/util/navigator_animator.dart';

import '../widgets/days_of_the_week_widget.dart';
import '../widgets/scheduler_widgets/list_of_schedule_tasks_widget.dart';

final watchTaskCountForEachDay = StateProvider<Map<String, int>>((ref) => {});

class TimeTableScreen extends ConsumerStatefulWidget {
  final int scheduleIndex;

  const TimeTableScreen({super.key, required this.scheduleIndex});

  @override
  ConsumerState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends ConsumerState<TimeTableScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  TimeOfDay fromTime = TimeOfDay.now();
  TimeOfDay toTime = TimeOfDay.now();
  TimeOfDay remindMeAt = TimeOfDay.now();
  int val = 0;
  int scheduleId = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchListOfSchedules = ref.watch(scheduleListNotifierProvider);
    final watchSelectedDay = ref.watch(selectedDayProvider);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: watchListOfSchedules.when(
          data: (data) {
            Schedule schedule = _filterSchedule(data, watchSelectedDay);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DaysOfTheWeekWidget(
                    scheduleName: schedule.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(watchSelectedDay,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '$val tasks',
                          style: TextStyle(
                              color: val > 0 ? Colors.green : Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListOfScheduleTaskWidget(
                    list: schedule.scheduleTasks ?? [],
                    func: (val) {},
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("An error occurred, please restart the app"),
            );
          },
          loading: () {
            return const Center(
                child: Column(
              children: [CircularProgressIndicator(), Text("Please wait..")],
            ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (val == 7) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text(
                        "Sorry, more task cannot be added for this day, You can only add at least 7 tasks"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ],
                  );
                },
              );
            } else {
              NavigatorAnimator.animateNavigateTor(
                  context,
                  AddANewCourse(
                    scheduleId: scheduleId,
                    selectedDay: watchSelectedDay,
                  ));
              /*SubmitScheduledTaskUtil.submitTask(v, watchSelectedDay, remindMeAt, ref, scheduleId);*/
            }
          },
          child: const Icon(Icons.add),
        ));
  }

  Schedule _filterSchedule(data, watchSelectedDay) {
    Schedule schedule = data[widget.scheduleIndex];
    scheduleId = schedule.id!;
    schedule.scheduleTasks?.reversed.toList();

    // Calculate the number of tasks for the selected day
    int tasksCount = schedule.scheduleTasks
            ?.where((task) => task.day == watchSelectedDay)
            .length ??
        0;
    val = tasksCount;

    return schedule;
  }
}
