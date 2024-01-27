import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_state_providers.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/screens/activity_screen.dart';
import 'package:studypal/screens/create_new_plan.dart';
import 'package:studypal/screens/home_page.dart';
import 'package:studypal/screens/session_screen.dart';
import 'package:studypal/screens/settings_screen.dart';

import '../models/study.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  ConsumerState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends ConsumerState<BottomNavigationScreen> {

  void prepareData()async{
    List<Plan> plans = await SavePlanToMemory.getAllPlans();
    ref.read(getPlanListProvider.notifier).update((state) => plans);
  }
  @override
  void initState() {
    // TODO: implement initState
    prepareData();
    super.initState();
  }
  int currentIndex=0;
  List<Widget> screenss = [
    HomePage(),
    SessionScreen(),
    ActivityScreen(),
    SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screenss[currentIndex],
        floatingActionButton: currentIndex!=0?null:FloatingActionButton(
            shape:  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
            child: const Icon(CupertinoIcons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateNewPlan(),));
            }
        ),
        bottomNavigationBar:BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex=value;
              });
            },
            unselectedItemColor: Color(0xFF9E9E9E),
            type: BottomNavigationBarType.fixed,
            items:const [

              BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet),label: "Tasks"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.timer_fill),label:"Sessions"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar_fill),label:"Activities"),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label:"Settings")
            ]
        )
    );
  }
}
