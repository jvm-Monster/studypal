import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/app_state_providers.dart';
import 'package:studypal/app_states/task_lists_notifier.dart';
import 'package:studypal/widgets/list_tile_widget.dart';

 
import '../models/task.dart';

class AnimatedTaskList extends ConsumerStatefulWidget {
  final GlobalKey<AnimatedListState> listKey;

  const AnimatedTaskList({super.key, required this.listKey});

  @override
  ConsumerState createState() => _AnimatedTaskListState();
}

class _AnimatedTaskListState extends ConsumerState<AnimatedTaskList> {
  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(taskListsNotifierProvider);

    final counter = ref.watch(counterProvider);
    return AnimatedList(
      key: widget.listKey,
      initialItemCount: lists.length,
      itemBuilder: (context, index, animation) {
        return ToDoListItemWidget(
            task: lists[index],
            animation: animation,
            onCompleted: () => removeItem(index, lists[index], counter));
      },
    );
  }

  void removeItem(index, Task taskToRemove, int counter) {
    Task task = taskToRemove;
    /*bool completed = task.completed == 0 ? false : true;
    task.completed = completed ? 0 : 1;
*/
    ref.read(taskListsNotifierProvider.notifier).deleteTask(task.id!);
    // Update the lists list with the modified task
    final removedItem = task;
    widget.listKey.currentState?.removeItem(
      index,
      (context, animation) => ToDoListItemWidget(
        task: removedItem,
        animation: animation,
        onCompleted: () {
        },
      ),
      duration: const Duration(milliseconds: 600),
    );
   /* if (counter > -1) {
      ref.read(counterProvider.notifier).state--;
    }*/


  }
}
