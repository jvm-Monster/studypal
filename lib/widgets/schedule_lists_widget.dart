import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/schedule_lists_notifier.dart';
import 'package:studypal/screens/time_table_screen.dart';
import 'package:studypal/util/navigator_animator.dart';
import 'package:studypal/widgets/add_course_status_snackbar.dart';

import '../models/schedule.dart';
import '../util/show_modal_input.dart';

//A provider that holds a selected schedule in the schedule lists
final selectedSchedule = StateProvider<Schedule?>((ref) => null);

class ScheduleListsWidget extends ConsumerStatefulWidget {
  const ScheduleListsWidget({super.key});

  @override
  ConsumerState createState() => _ScheduleListsWidgetState();
}

class _ScheduleListsWidgetState extends ConsumerState<ScheduleListsWidget> {
  @override
  Widget build(BuildContext context) {
    final scheduleLists = ref.watch(scheduleListNotifierProvider);

    return scheduleLists.when(
      data: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            Schedule schedule = data[index];
            TextEditingController newScheduleNameEditingController =
                TextEditingController(text: schedule.name);

            return ListTile(
              onTap: () {
                ref.read(selectedSchedule.notifier).update((state) => schedule);
                NavigatorAnimator.animateNavigateTor(
                    context, TimeTableScreen(scheduleIndex: index));
                //Navigator.push(context, MaterialPageRoute(builder: (context) => TimeTableScreen(scheduleIndex: index)));
              },
              title: Text(schedule.name),
              trailing: PopupMenuButton<int>(
                icon: const Icon(CupertinoIcons.ellipsis_vertical),
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: const Text('Edit'),
                    onTap: () {
                      ShowModalInputField.showAddScheduleSheet(
                        context,
                        textEditingController: newScheduleNameEditingController,
                        ref: ref,
                        inputLabelText: "Edit time table",
                        onSubmitted: (value) async {
                          bool success = await ref
                              .read(scheduleListNotifierProvider.notifier)
                              .updateSchedule(
                                  newName:
                                      newScheduleNameEditingController.text,
                                  scheduleId: schedule.id);
                          editScheduleName(success);
                        },
                      );
                    },
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: const Text('Delete'),
                    onTap: () async {
                      /* // Handle Delete action
                    bool success  = await SavePlanToMemory.removePlan(index);
                    if(success){
                      final List<Plan> updatedList = List.from(planListWatch);
                      updatedList.removeAt(index);
                      ref.read(getPlanListProvider.notifier).update((state) => updatedList);
                    }*/
                    },
                  ),
                  // Add more options as needed
                ],
                onSelected: (value) async {
                  // Handle the selected option
                  if (value == 0) {
                    // Handle Edit action
                  } else if (value == 1) {
                    // Handle Delete action
                    await ref
                        .read(scheduleListNotifierProvider.notifier)
                        .deleteSchedule(data[index].id!);
                  }
                  // Add more cases if needed
                },
              ),
            );
          },
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("An error occurred,please exit the app and open again"),
      ),
      loading: () {
        return const Center(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  editScheduleName(bool success) async {
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const AddCourseStatusSnackBar(
          content: Text("Name changed successfully")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const AddCourseStatusSnackBar(
        content: Text("Name changed unsuccessfully"),
        bgColor: Colors.red,
      ));
    }
  }
}
