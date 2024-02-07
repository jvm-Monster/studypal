import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_state_providers.dart';
import 'package:studypal/widgets/task_view_design_widget.dart';

import '../memeory/save_plan_to_memory.dart';
import '../models/plan_days.dart';
import '../models/study.dart';
class DayTasks extends ConsumerStatefulWidget {
  final Plan plan;
  final String selectedDay;
  final int planSelectedIndex;
  DayTasks({super.key,required this.plan,required this.planSelectedIndex,required this.selectedDay});


  @override
  ConsumerState createState() => _DayTasksState();
}

class _DayTasksState extends ConsumerState<DayTasks> {
  List<Map<String,dynamic>> particularDayTasks=[];
  @override
  Widget build(BuildContext context) {
    particularDayTasks=checkSelectedDay(widget.plan);
    final val = ref.watch(getPlanListProvider);
    if(particularDayTasks.isEmpty){
      return const Text("No task for this day");
    }
    return ListView.builder(
      itemCount: particularDayTasks.length,
      itemBuilder: (context, index) {
        if(particularDayTasks.isEmpty){
          return const Text("No task for this day");
        }
        else{
          Map<String,dynamic> task = particularDayTasks[index];

          return  Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.grey,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) async{

                bool success = await SavePlanToMemory.removeATask(widget.planSelectedIndex, widget.selectedDay, index);
                if(success){
                  particularDayTasks.removeAt(index);

                }else{
                  print('it never removed');
                }
                //I tried using ref to update the state, but i can't think, so the simplest way
                //is to call setstate to just rebuild the widget.
                setState(() {

                });
              },
              child: TaskViewDesignWidget(task: task['task'], time: task['time']));
        }
      },);
  }



  List<Map<String,dynamic>> checkSelectedDay(Plan plan){
    PlanDays? planDays = plan.planDays;
    List<Map<String,dynamic>> planDayPlans = [];
    if(planDays==null){
      return [];
    }
    else{
      switch(widget.selectedDay){
        case 'Monday' : planDayPlans=planDays.monday;break;
        case 'Tuesday' : planDayPlans=planDays.tuesday;break;
        case 'Wednesday' : planDayPlans=planDays.wednesday;break;
        case 'Thursday':  planDayPlans=planDays.thursday;break;
        case 'Friday' : planDayPlans=planDays.friday;break;
        case 'Saturday' : planDayPlans=planDays.saturday;break;
        case 'Sunday' : planDayPlans=planDays.sunday;break;
      }
      return planDayPlans;
    }

  }

}


