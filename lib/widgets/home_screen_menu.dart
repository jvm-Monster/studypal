import 'package:flutter/material.dart';

import '../screens/schedules_screen.dart';
import '../screens/todo_screen.dart';
import '../util/navigator_animator.dart';
import 'home_buttons_widget.dart';

class HomeScreenMenu extends StatelessWidget {
  const HomeScreenMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HomeButtonsWidget(
          name: "Time Table",
          icon: const Icon(Icons.calendar_today),
          function: () {
            NavigatorAnimator.animateNavigateTor(
                context, const ScheduleScreen());
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduleScreen(),));
          },
        ),
        HomeButtonsWidget(
          name: "View all",
          icon: const Icon(Icons.view_list),
          function: () {

            NavigatorAnimator.animateNavigateTor(
              context,
              const ToDoScreen(),
            );
          },
        ),
        // HomeButtonsWidget(
        //   name: "Completed",
        //   icon: const Icon(Icons.done_all),
        //   function: () {},
        // )
      ],
    );
  }
}
