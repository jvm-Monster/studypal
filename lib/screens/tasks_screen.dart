import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/screens/create_new_plan.dart';
import 'package:studypal/widgets/plan_list_widget.dart';
import 'package:studypal/widgets/show_plan_widget.dart';

import '../widgets/app_bar_widget.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Plans"),
        actions: [
          IconButton(onPressed: (){

          }, icon: const Icon(CupertinoIcons.clear))
        ],
      ),

      body:  const ViewPlanListWidget(),
      floatingActionButton:FloatingActionButton(
          shape:  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
          child: const Icon(CupertinoIcons.add),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewPlan(),));
          }
      ),
    );
  }
  

}
