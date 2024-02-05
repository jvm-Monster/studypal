import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_state_providers.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/models/study.dart';
import 'package:studypal/widgets/add_task_to_plan_widget.dart';
import 'package:studypal/widgets/app_bar_widget.dart';

class CreateNewPlan extends ConsumerStatefulWidget {
  const CreateNewPlan({super.key});

  @override
  ConsumerState createState() => _CreateNewPlanState();
}

class _CreateNewPlanState extends ConsumerState<CreateNewPlan> {
  TextEditingController planNameController = TextEditingController();
  TextEditingController planDescriptionController = TextEditingController();
  Plan? plan;

  bool isReminderEnabled=false;
  bool createPlan = false;
  @override
  Widget build(BuildContext context) {
    final planListWatch = ref.read(getPlanListProvider);
    return Scaffold(
      appBar:const PreferredSize(preferredSize: Size.fromHeight(50), child: AppBarWidget(appBarTitile: "Create new plan")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 TextField(
                   controller: planNameController,
                   decoration: InputDecoration(
                     labelText: 'Plan name',
                     labelStyle: const TextStyle(
                       color: Colors.grey
                     ),
                     border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                     )
                   ),
                 ),
                const SizedBox(height: 20,),
          
                TextField(
                  controller: planDescriptionController,
                  maxLength: 100,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Plan Description',
                      labelStyle: const TextStyle(
                          color: Colors.grey
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                const SizedBox(height: 20,),
          
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   ElevatedButton(onPressed: (){
                     addToPlanList(planListWatch);
                     Navigator.pop(context);
                     }, child: const Text("Create Plan")),
                   Column(
                     children: [
                       const Text("Set Reminder"),
                       Switch(
                         value: isReminderEnabled,
                         onChanged: (value) {
                           setState(() {
                             isReminderEnabled = value;
                           });
                         },
                       ),
                     ],
                   )
                 ],
               )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addToPlanList(planListWatch)async{
    plan=Plan(planName: planNameController.text, planDescription: planDescriptionController.text);
    if(plan!=null){
      bool success = await SavePlanToMemory.addPlan(plan:plan!);
      if(success){
        final List<Plan> updatedList = List.from(planListWatch);
        updatedList.add(plan!);
        ref.read(getPlanListProvider.notifier).update((state) => updatedList);
      }
    }else{
      const SnackBar(content: Text("Could not add plan"));
    }
  }
}
