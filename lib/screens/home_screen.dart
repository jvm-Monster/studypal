import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/app_state_providers.dart';
 
import 'package:studypal/memory/user_prefrences/user_theme_preferences.dart';
import 'package:studypal/screens/setting_screen.dart';
import 'package:studypal/widgets/home_screen_menu.dart';
import 'package:studypal/widgets/todo_widget.dart';

import '../widgets/quote_widget.dart';
import '../widgets/today_task_schedule_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
 
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        PreferredSize(preferredSize: const Size.fromHeight(15), child: AppBar(
          title:  getGreeting(),
          actions: [
             IconButton(
                  onPressed: () {
                    ref.read(studyPalThemeProvider.notifier).update(
                          (state) => UserThemePreferences.getUserThemeMode(),
                        );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ));
                  },
                  icon: const Icon(Icons.settings))
            ],
          
        )),
        Expanded(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child:  const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                       
                      children: [
                       HomeScreenMenu(),
                        SizedBox(
                          height: 10,
                        ),

                        NextScheduleTaskCard(),

                        SizedBox(
                          height: 10,
                        ),
                        ToDoWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    QuoteWidget(),

                  ],
                ),
              ),
            ),
          ),
        ),



      ],
    );
  }

  Widget getGreeting() {
    TimeOfDay now = TimeOfDay.now();
    Text greeting;
    if (now.period == DayPeriod.am) {
      greeting =
          const Text("Good Morning 🌄🌄", style: TextStyle(fontSize: 25));
    } else if (now.hour > 11 && now.hour < 16 && now.period == DayPeriod.pm) {
      greeting =
          const Text("Good Afternoon 🌙🌙", style: TextStyle(fontSize: 25));
    } else if (now.hour >= 16 && now.hour < 21 && now.period == DayPeriod.pm) {
      greeting =
          const Text("Good Evening 🌃🌃", style: TextStyle(fontSize: 25));
    } else {
      greeting = const Text("Good Night 🌑🌑", style: TextStyle(fontSize: 25));
    }

    return greeting;
  }
}
