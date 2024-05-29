import 'package:flutter/material.dart';
import 'package:studypal/util/days_of_the_week.dart';

import '../models/schedule.dart';
import '../models/schedule_task.dart';
 

class NextScheduleTasks{


  static List<ScheduleTask> filterTaskForToday(List<Schedule> data){

    List<ScheduleTask> amTasks = [];
    List<ScheduleTask> pmTasks = [];
    DateTime date = DateTime.now();


    for (Schedule schedule in data) {
      schedule.scheduleTasks?.forEach((task) {
        int taskDay = DaysOfTheWeek.parseDayOfWeek(task.day);
        if(taskDay== date.weekday){
          if(task.dueDate.contains("am")){
            amTasks.add(task);
          }else{
            pmTasks.add(task);
          }
        }
      },);
    }

    sortTaskBaseOnTime(amTasks);
    sortTaskBaseOnTime(pmTasks);

    return mergeTasks(amTasks, pmTasks);
  }

  static List<ScheduleTask> removePassedTasks(List<ScheduleTask> tasks){
    print("initial tasks $tasks");
    DateTime dateTime = DateTime.now();
    DateTime now = DateTime(1,1,1,dateTime.hour,dateTime.minute);
    for(int i=0; i<tasks.length; i++){
      print(i);
        String time1 =  tasks[i].dueDate.split(' ')[0];
        DateTime t1 = _parseTime(time1);
        if(t1.isBefore(now)){
          tasks.removeAt(i);
          print(tasks);
        }
      }
 
    return tasks;
  }

  static sortTaskBaseOnTime(List<ScheduleTask> tasks){
    //remove tasks that has already been done or passed
    List<ScheduleTask> newModifiedTasks = removePassedTasks(tasks);
    if(newModifiedTasks.isEmpty){
      return newModifiedTasks;
    }
    newModifiedTasks.sort((task1, task2) {
      // Extract the time part from the dueDate string
      String time1 = task1.dueDate.split(' ')[0];
      String time2 = task2.dueDate.split(' ')[0];

      // Parse the time strings into DateTime objects
      DateTime dueTime1 = _parseTime(time1);
      DateTime dueTime2 = _parseTime(time2);

      // Compare the due times
      return dueTime1.compareTo(dueTime2);
    });
   
    return newModifiedTasks;
  }

// Function to parse time string into DateTime object
  static DateTime _parseTime(String timeString) {
    // Split the time string into hours, minutes, and AM/PM indicator
    List<String> parts = timeString.split(' ');
    List<String> timeParts = parts[0].split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);

    // // Adjust hours for PM times
    // if (parts.length > 1 && parts[1].toLowerCase() == 'pm' && hours != 12) {
    //   hours += 12;
    // }
    // Parse the time string into a DateTime object
    return DateTime(1, 1, 1, hours, minutes);
  }

  static List<ScheduleTask> mergeTasks(List<ScheduleTask>amTasks,List<ScheduleTask>pmTasks){
    List<ScheduleTask> mergedTasks = [];
    // DayPeriod checkPmOrAm = TimeOfDay.now().period;



    mergedTasks.addAll(amTasks);
    mergedTasks.addAll(pmTasks);

   /* if(checkPmOrAm == DayPeriod.pm){
      return mergedTasks.reversed.toList();
    }*/

    return mergedTasks;
  }


}