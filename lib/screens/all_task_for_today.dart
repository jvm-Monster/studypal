import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskForToday extends ConsumerStatefulWidget {
  const TaskForToday({super.key});

  @override
  ConsumerState createState() => _TaskForTodayState();
}

class _TaskForTodayState extends ConsumerState<TaskForToday> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today")),
    );
  }
}
