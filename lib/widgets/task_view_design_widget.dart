import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studypal/widgets/random_picker_widget.dart';

class TaskViewDesignWidget extends StatelessWidget {
  final String task;
  final String time;
  const TaskViewDesignWidget({super.key,required this.task, required this.time});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RandomColorPicker(),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task, style: const TextStyle(fontSize: 15)),
                Text(time, style: const TextStyle(color: Colors.grey)),
              ],
            )

          ],
        ),
        const SizedBox(height: 15,)
      ],
    );
  }
}
