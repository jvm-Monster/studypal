import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/memory/database/schedule_database_helper.dart';
import 'package:studypal/widgets/schedule_lists_widget.dart';

import '../models/schedule.dart';
import 'app_time_picker.dart';

final checkBoxDayListProvider = StateProvider<List<String>>((ref) => []);
final checkBoxAlarmListProvider = StateProvider<List<TimeOfDay>>((ref) => []);
final checkBoxAlarmProvider = StateProvider<Map<String, TimeOfDay>>(
  (ref) => {},
);

class CheckBoxDayList extends ConsumerStatefulWidget {
  const CheckBoxDayList({super.key});

  //final VoidCallback verifyCheckedButton;

  @override
  ConsumerState createState() => _CheckBoxDayListState();
}

class _CheckBoxDayListState extends ConsumerState<CheckBoxDayList> {
  final List<String> _items = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  bool ver = false;

  @override
  Widget build(BuildContext context) {
    final watchSchedule = ref.watch(selectedSchedule);
    final watchCheckBoxAlarmProvider = ref.watch(checkBoxAlarmProvider);

    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
            title: Text(_items[index]),
            value: watchCheckBoxAlarmProvider.containsKey(_items[index]),
            onChanged: (newValue) async {
              int numberOfTasks =
                  await checkNumberOfTasks(watchSchedule!, _items[index]);
              if (numberOfTasks == 7) {
                _alertBox(_items[index]);
              } else {
                createAlarm(newValue, watchCheckBoxAlarmProvider, index);
              }
            });
      },
    );
  }

  void createAlarm(bool? checked,
      Map<String, TimeOfDay> watchCheckBoxAlarmProvider, index) async {
    Map<String, TimeOfDay> copiedData = {};
    if (checked!) {
      // set time
      TimeOfDay? time = await _setTime();
      copiedData.addAll(watchCheckBoxAlarmProvider);
      copiedData.putIfAbsent(_items[index], () => time ?? TimeOfDay.now());
      ref.read(checkBoxAlarmProvider.notifier).update((state) => copiedData);
    } else {
      watchCheckBoxAlarmProvider.remove(_items[index]);
      copiedData.addAll(watchCheckBoxAlarmProvider);
      ref.read(checkBoxAlarmProvider.notifier).update((state) => copiedData);
    }
  }

  Future<int> checkNumberOfTasks(Schedule schedule, day) async {
    final int? val =
        await ScheduleDatabaseHelper.getNumberOfTaskForAParticularDay(
            schedule.id!, day);
    return val!;
  }

  Future<TimeOfDay?> _setTime() async {
    return await AppTimePicker.setTime(context,
        textMessage: "Always remind me at :");
  }

  void _alertBox(String day) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Sorry, you can't add any more task to $day,"),
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
  }
}
