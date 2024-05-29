import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/schedule_lists_notifier.dart';
import 'package:studypal/models/schedule.dart';
import 'package:studypal/widgets/schedule_lists_widget.dart';

import '../util/show_modal_input.dart';

final scrollControllerProvider =
    ChangeNotifierProvider<ScrollController>((ref) => ScrollController());

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedules"),
      ),
      body: const ScheduleListsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowModalInputField.showAddScheduleSheet(
            context,
            textEditingController: _textEditingController,
            ref: ref,
            inputLabelText: "Create a new time table",
            onSubmitted: (value) {
              _addNewSchedule(value);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // creating new schedule
  void _addNewSchedule(String scheduleName) async {
    final newScheduleName = scheduleName;
    if (newScheduleName.isNotEmpty) {
      // Perform your logic to add the new schedule
      Schedule schedule = Schedule(name: newScheduleName);
      ref.read(scheduleListNotifierProvider.notifier).createSchedule(schedule);
      _textEditingController.clear();
    }
  }
}
