import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/models/plan_days.dart';
import 'package:studypal/screens/add_task_to_plan_screen.dart';
import 'package:studypal/widgets/day_button_widget.dart';
import 'package:studypal/widgets/day_task_list_widget.dart';
import 'package:studypal/widgets/random_picker_widget.dart';

import '../app_state_providers.dart';
import '../models/study.dart';

final selectedDayProvider = StateProvider((ref) => 'Monday');
class ShowPlanWidget extends ConsumerStatefulWidget {
  final int planSelectedIndex;
  const ShowPlanWidget({super.key,required this.planSelectedIndex});

  @override
  ConsumerState createState() => _ShowPlanWidgetState();
}

class _ShowPlanWidgetState extends ConsumerState<ShowPlanWidget> {


  @override
  Widget build(BuildContext context) {

    final plans = ref.watch(getPlanListProvider);//list of task in a plan
    final selectedDay = ref.watch(selectedDayProvider); // watch the selected day user click to show tasks
    Plan  plan = plans[widget.planSelectedIndex];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Task"),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskToPlanScreen(widget.planSelectedIndex,selectedDay),));
              },
              child: const Text('Add Task')
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(plan.planName,style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xff0088FF).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10)
              ),
      
              child: const Padding(
                padding:EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DayButtonWidget(text: "Monday"),
                    DayButtonWidget(text: "Tuesday"),
                    DayButtonWidget(text: "Wednesday"),
                    DayButtonWidget(text: "Thursday"),
                    DayButtonWidget(text: "Friday"),
                    DayButtonWidget(text: "Saturday"),
                    DayButtonWidget(text: "Sunday"),

                  ],),
              ),
            ),
      
            const SizedBox(height: 20,),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedDay, style: const TextStyle(fontWeight: FontWeight.bold,fontSize:25)),
                    const SizedBox(height: 10,),
                    SizedBox(
                       height: MediaQuery.of(context).size.height*0.55,
                       width: MediaQuery.of(context).size.width,
                       child: DayTasks(plan: plan, planSelectedIndex: widget.planSelectedIndex, selectedDay: selectedDay)
                     )
                  ],
                ),
              ),
            )
      
          ],
        ),
      ),
    );
  }

  listTasks(Plan plan,String selectedDay){
    List<Map<String,dynamic>> day = checkSelectedDay(plan,selectedDay);
    return ListView.builder(
      itemCount: day.length,
      itemBuilder: (context, index) {
        if(day.isEmpty){
          return const Text("No task for this day");
        }
        else{
          Map<String,dynamic> task = day[index];

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

              bool success = await SavePlanToMemory.removeATask(widget.planSelectedIndex, selectedDay, index);
              if(success){
                day.removeAt(index);
              }else{
                print('it never removed');
              }
              setState(() {
              });
            },
            child: taskWidget(task['task'], task['time']),
          );
        }
    },);
  }

  List<Map<String,dynamic>> checkSelectedDay(Plan plan,String selectedDay){
    PlanDays? planDays = plan.planDays;
    List<Map<String,dynamic>> planDayPlans = [];
    if(planDays==null){
      return [];
    }
    else{
      switch(selectedDay){
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



  Widget days(String text,String selectedDay){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDay = text;
        });
      },
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 50
          ),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text.substring(0,3),style: const TextStyle(color: Color(0xff0088FF),fontWeight: FontWeight.bold),),
            ),
          ),
        ),
      ),
    );
  }

  Widget taskWidget(String task, String time){
    return   Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RandomColorPicker(),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task, style: const TextStyle(fontSize: 15)),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            )

          ],
        ),
        const SizedBox(height: 15,)
      ],
    );

  }


}
