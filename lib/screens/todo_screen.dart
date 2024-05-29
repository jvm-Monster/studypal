import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studypal/widgets/animated_task_list.dart';

import '../app_states/schedule_lists_notifier.dart';
import '../models/schedule_task.dart';
import '../util/next_schedule_tasks.dart';

class ToDoScreen extends ConsumerStatefulWidget {
  const ToDoScreen({super.key});

  @override
  createState() => _ToDoScreenState();
}

class _ToDoScreenState extends ConsumerState<ToDoScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final now = DateTime.now();
  final dateFormat = DateFormat('EEEE, MMMM d');
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watchListOfSchedules = ref.watch(scheduleListNotifierProvider);

    final formattedDate = dateFormat.format(now);

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Day"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Schedules'), // First tab
              Tab(text: 'Tasks'), // Second tab
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: [
                      watchListOfSchedules.when(
                          data: (data) {
                            List<ScheduleTask> sortedTask = NextScheduleTasks.filterTaskForToday(data);

                            // Content for Time Table tab
                            return ListView.builder(
                              itemCount: sortedTask.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            sortedTask[index].name,
                                            style: const TextStyle(fontSize: 15),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(sortedTask[index].description??""),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Lead : ${sortedTask[index].lead!}',
                                                style: const TextStyle(color: Colors.grey),
                                              ),
                                              Text(
                                                sortedTask[index].dueDate,
                                                style: const TextStyle(color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            );
                          },
                          error: (error, stackTrace) {
                            return const Text("An error occured");
                          },
                          loading: () => const CircularProgressIndicator(),
                      ),


                      // Content for Random Task tab
                     AnimatedTaskList(listKey: _listKey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
  Widget animateList(List<Task> taskss){
    List<Task> tasks = taskss.where((task) => task.completed==0).toList();

    return AnimatedList(
      key: _listKey,
      initialItemCount: tasks.length,
      itemBuilder: (context, index, animation) {
        if(index<tasks.length){
          return ToDoListItemWidget(
              task: tasks[index],
              animation: animation,
              onCompleted: ()=>removeItem(index,tasks[index]));
        }
        return Container();
      },
    );
  }



  void removeItem(index, Task taskToRemove) {

    Task task = taskToRemove;
    bool completed = task.completed == 0 ? false : true;
    task.completed = completed ? 0 : 1;

    ref.read(taskListsNotifierProvider.notifier).updateTask(task);
    // Update the lists list with the modified task
    final removedItem = task;
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => ToDoListItemWidget(
        task: removedItem,
        animation: animation,
        onCompleted: () {},
      ),
      duration: const Duration(milliseconds: 600),
    );
  }
}
*/
