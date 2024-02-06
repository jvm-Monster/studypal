import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_state_providers.dart';
import 'package:studypal/util/confirm_selected_day.dart';
import 'package:studypal/util/create_alarm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/study.dart';

class AddTaskToPlanScreen extends ConsumerStatefulWidget {
  final int index;
  final String daySelected;
  const AddTaskToPlanScreen(this.index,this.daySelected, {super.key});

  @override
  ConsumerState createState() => _AddTaskToPlanState();
}

class _AddTaskToPlanState extends ConsumerState<AddTaskToPlanScreen> {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // final format = DateFormat("yyyy-MM-dd HH:mm");

  // Variable to store the selected time
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController taskEditController = TextEditingController();
  @override

  @override
  Widget build(BuildContext context) {
    final watchPlan = ref.watch(getPlanListProvider);

    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add A New Task"),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*const DayDropDownWidget(),*/
            const SizedBox(height: 20,),
            TextField(
              controller: taskEditController,
              decoration: InputDecoration(
                  labelText: 'Write task here!',
                  labelStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            const SizedBox(height: 20,),
            pickTime()

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () async{
          createAlarm(watchPlan);
          Navigator.pop(context);
        },
      ),
    );
    }

    Widget pickTime(){
    return  ElevatedButton(
      onPressed: () async {
        // Show the time picker and store the result in selectedTime
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );

        // Check if the user actually picked a time
        if (pickedTime != null) {
          setState(() {
            selectedTime = pickedTime;
          });
        }
      },
      child: Text('Set time : ${selectedTime.format(context)}'),

    );
    }

    Future<void>createAlarm(List<Plan> watchPlan) async {
      ConfirmSelectedDay confirmSelectedDay = ConfirmSelectedDay(
          watchPlan: watchPlan,
          selectedDay: widget.daySelected,
          index: widget.index,
          task: taskEditController.text,
          selectedTime:
          selectedTime.format(context),
          ref: ref
      );
      bool success = await confirmSelectedDay.confirmSelectedDay();
      if(success){
        CreateAlarm alarm = CreateAlarm(text: taskEditController.text, timeOfDay:selectedTime, context: context);
        alarm.createAlarmForTask();
      }else{

      }
    }




 
}
