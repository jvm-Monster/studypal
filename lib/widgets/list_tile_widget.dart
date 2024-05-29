import 'package:flutter/material.dart';

import '../models/task.dart';

class ToDoListItemWidget extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final VoidCallback onCompleted;

  const ToDoListItemWidget(
      {super.key,
      required this.task,
      required this.animation,
      required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      key: ValueKey(task.id),
      sizeFactor: animation,
      child: buildItem(),
    );
  }

  Widget buildItem() {
    return Card(
        child: ListTile(
      dense: true,
      title: Text(
        task.name,
      ),
      leading: IconButton(
        onPressed: onCompleted,
        icon: checkIfTaskCompleted(task.completed),
      ),
    ));
  }

  Widget checkIfTaskCompleted(int completed) {
    return completed == 1
        ? const Icon(
            Icons.check_circle,
            color: Colors.green,
          )
        : const Icon(
            Icons.circle_outlined,
            color: Colors.grey,
          );
  }
}
/*
bool completed = task.completed==0?!false:!true;
task.completed=completed==false?0:1;
ref.read(taskListsNotifierProvider.notifier).updateTask(task);*/
