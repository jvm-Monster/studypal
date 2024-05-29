import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/models/schedule_task.dart';
import 'package:studypal/screens/todo_screen.dart';
import 'package:studypal/util/navigator_animator.dart';
import 'package:studypal/util/next_schedule_tasks.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../app_states/schedule_lists_notifier.dart';
class NextScheduleTaskCard extends ConsumerStatefulWidget {
  const NextScheduleTaskCard({super.key});

  @override
  ConsumerState createState() => _NextScheduleTaskCardState();
}

class _NextScheduleTaskCardState extends ConsumerState<NextScheduleTaskCard> {
  // Controller
  final CountdownController _controller =  CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    final watchListOfSchedules = ref.watch(scheduleListNotifierProvider);
    
    return watchListOfSchedules.when(
        data: (data) {
            List<ScheduleTask> sortedTask = NextScheduleTasks.filterTaskForToday(data);

            
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 10,
                    ),
                   Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Today",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                NavigatorAnimator.animateNavigateTor(context, const ToDoScreen());
                              },
                              icon: const Icon(
                                CupertinoIcons.arrow_right_circle_fill,
                                color: Colors.grey,
                              )),
                        ],
                      ),
                    ),
                //ScheduleTask scheduleTask = sortedTask[index];
             Card(
              surfaceTintColor:Colors.transparent,
                elevation: 0.0,
                color: Colors.blueAccent.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Added padding around each card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sortedTask.isEmpty?Container():courseNameAndTimeWidget(sortedTask[0], 0),
                      sortedTask.isEmpty?Container():leadNameAndCounterTime(sortedTask[0], 0)
                    ],
                  ),
                ),
              ),
                   /* Container(
                      constraints: const BoxConstraints(
                        maxHeight: 100,

                      ),
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal, // Changed scroll direction to vertical
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 0.35,
                          mainAxisSpacing: 10
                        ),
                        itemCount: sortedTask.length,
                        itemBuilder: (context, index) {

                          }

                      ),
                    ),
*/

                  ],
                ),
              ),
            );
        },
        error: (error, stackTrace) {
            return const Text("could not get the next task");
        },
        loading:() => const CircularProgressIndicator(),);

  }
  Widget courseNameAndTimeWidget(ScheduleTask scheduleTask,index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          scheduleTask.name,
          style: TextStyle(
              color: index==0?Colors.black:Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        Text(
          scheduleTask.dueDate,
          overflow: TextOverflow.ellipsis,
          style:TextStyle(
              color: index==0?Colors.black:null,
              fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget leadNameAndCounterTime(ScheduleTask scheduleTask,index){

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Lead : ${scheduleTask.lead!}',
          style: TextStyle(
              color: index==0?Colors.black:null,
              fontSize: 15
          ),
        ),

       index==0?Container(
         decoration: BoxDecoration(
           color: Theme.of(context).scaffoldBackgroundColor,
           borderRadius: const BorderRadius.all(Radius.circular(10))
         ),
         child: const Padding(
           padding: EdgeInsets.all(5.0),
           child: Text("next"),
         ),
       ):Container()
       /* index==0?CountdownTimer(
          controller: controller,
          onEnd: () {},
          endTime: 2000,
          widgetBuilder: (context, time) {
            return Text(
              "",
              style:TextStyle(
                  color: index==0?Colors.black:null,
                  fontSize: 15
              ),
            );
          },
        ):Container(),*/
      ],
    );
  }
}
