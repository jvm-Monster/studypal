import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_state_providers.dart';
import '../memeory/save_plan_to_memory.dart';
import '../models/study.dart';

class ConfirmSelectedDay{

  late List<Plan> updatedList;
  String task;
  String selectedTime;
  String selectedDay;
  int index;
  List watchPlan;
  WidgetRef ref;

  ConfirmSelectedDay({
    required this.watchPlan,
    required this.selectedDay,
    required this.index,
    required this.task,
    required this.selectedTime,
    required this.ref
  });

  Future<bool> confirmSelectedDay()async{
    updatedList=List.from(watchPlan);
    // Define a map to associate weekdays with their corresponding planDays property
    Map<String, List<Map<String, dynamic>>> dayMap = {
      'Monday': updatedList[index].planDays!.monday,
      'Tuesday': updatedList[index].planDays!.tuesday,
      'Wednesday': updatedList[index].planDays!.wednesday,
      'Thursday': updatedList[index].planDays!.thursday,
      'Friday': updatedList[index].planDays!.friday,
      'Saturday': updatedList[index].planDays!.saturday,
      'Sunday': updatedList[index].planDays!.sunday,
    };
    // Use the dayMap to update the corresponding list based on the selected day
    dayMap[selectedDay]!.add({
      "task": task,
      "time": selectedTime,
    });
    bool success = await _addToPlanList(updatedList[index],updatedList);
    return success;
  }

  Future<bool> _addToPlanList(Plan plan,updatedList)async{

    /*bool success = await savePlanToMemory(plan,index);*/
    bool success = await SavePlanToMemory.addPlan(plan: plan,index: index);
    if(success){
      ref.read(getPlanListProvider.notifier).update((state) => updatedList);
      return success;
    }
    return false;
  }

}