import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/util/submit_scheduled_task_util.dart';

import '../../models/schedule_task.dart';
import '../single_task_widget.dart';

final selectedDayProvider = StateProvider((ref) => "Monday");

class ListOfScheduleTaskWidget extends ConsumerStatefulWidget {
  final List<ScheduleTask> list;
  final void Function(int val) func;

  const ListOfScheduleTaskWidget(
      {super.key, required this.list, required this.func});

  @override
  ConsumerState createState() => _ListOfScheduleTaskWidgetState();
}

class _ListOfScheduleTaskWidgetState
    extends ConsumerState<ListOfScheduleTaskWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return const Center(child: Text("No task for this day"));
    }
    return filterScheduledTaskList();
  }

  Widget filterScheduledTaskList() {
    final selectedDay = ref.watch(selectedDayProvider); //watch for changes

    //filter the tasks of the schedule by the selected day
    final filterScheduleTaskByDay =
        widget.list.reversed.where((task) => task.day == selectedDay).toList();

    // check if the task filtered for they specific day is empty
    if (filterScheduleTaskByDay.isEmpty) {
      return const Center(child: Text("No task for this day"));
    }

    widget.func(filterScheduleTaskByDay.length);

    return ListView.builder(
      itemCount: filterScheduleTaskByDay.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        ScheduleTask scheduleTask = filterScheduleTaskByDay[index];
        return Column(
          children: [
            Dismissible(
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30),
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              key: UniqueKey(),
              child:  SingleTaskWidget(
                scheduleTask: scheduleTask,
                scheduleTaskIndex: index,
              ),
              onDismissed: (direction) {
                SubmitScheduledTaskUtil.deleteTask(ref, scheduleTask.id!);
              },
            ),
          ],
        );
      },
    );
  }
}
