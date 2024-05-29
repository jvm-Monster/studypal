import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/app_state_providers.dart';
import 'package:studypal/screens/todo_screen.dart';
import 'package:studypal/util/navigator_animator.dart';
import 'package:studypal/widgets/animated_task_list.dart';

import '../app_states/task_lists_notifier.dart';
import '../models/task.dart';

class ToDoWidget extends ConsumerStatefulWidget {
  const ToDoWidget({super.key});

  @override
  ConsumerState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends ConsumerState<ToDoWidget> {
  TextEditingController taskEditController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void insertItem(Task task) {
    int newId = 0;
    ref.read(addedListProvider.notifier).state.insert(newId, task);
    _listKey.currentState
        ?.insertItem(newId, duration: const Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    final counter = ref.watch(counterProvider);
    return Card(
      /*surfaceTintColor: Colors.blueAccent,*/
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.check_box_rounded,
                      color: Colors.blue,
                    ),
                    Text("Tasks"),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          NavigatorAnimator.animateNavigateTor(
                            context,
                            const ToDoScreen(),
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const ToDoScreen(),));
                        },
                        icon: const Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: Colors.blue,
                      )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Quickly add what you would like to do today"),
                  )),
            ),
            Card(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        Task task = Task(
                            name: taskEditController.text,
                            description: "",
                            dueDate: "",
                            completed: 0);
                        int value = await ref
                            .read(taskListsNotifierProvider.notifier)
                            .createNewTask(task);
                        task.id = value;
                        if (task.id! > 0) {
                          showTaskAddedMessage();
                        }
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.blue.shade800,
                      )),
                  Expanded(
                    child: TextField(
                      controller: taskEditController,
                      cursorOpacityAnimates: true,
                        onSubmitted: (value) {
                        Task task = Task(name: taskEditController.text,
                            description: "",
                            dueDate: "");
                        // Call the createNewTask method to add the task to the database
                           insertItem(task);
                      },

                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: "Add Task",
                        labelStyle: TextStyle(color: Colors.blue),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusColor: Colors.transparent,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
                height: counterFunction(counter),
                duration: const Duration(milliseconds: 500),
                child: AnimatedTaskList(listKey: _listKey)),
            counter > 1
                ? AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: TextButton(
                        onPressed: () {
                          NavigatorAnimator.animateNavigateTor(
                              context, const ToDoScreen());
                          /* Navigator.push(context, MaterialPageRoute(builder: (context) => const ToDoScreen(),));*/
                        },
                        child: const Text("More")),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  double counterFunction(counter) {
    if (counter < 0) {
      counter - 1;
    }
    return counter == 0
        ? 1
        : counter == 1
            ? 130
            : 150;
  }

  void showTaskAddedMessage() {
    final snackBar = SnackBar(
      content: const Text('Your task have been added '),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      behavior: SnackBarBehavior.floating,

      action: SnackBarAction(
        label: "see tasks",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ToDoScreen(),));
        },
      ),
      duration: const Duration(seconds: 3), // Adjust duration as needed
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
