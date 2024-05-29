import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/task_lists_notifier.dart';
class MyDayTaskTab extends ConsumerStatefulWidget {
  const MyDayTaskTab({super.key});

  @override
  ConsumerState createState() => _MyDayTaskTabState();
}

class _MyDayTaskTabState extends ConsumerState<MyDayTaskTab> {
  @override
  Widget build(BuildContext context) {
    final watchTasks = ref.watch(taskListsNotifierProvider);
    print(watchTasks);

          return   ListView.builder(
            itemCount: watchTasks.length,
            itemBuilder: (context, index) {
              print('index $index');
        return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(watchTasks[index].name,),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                    Icons.check_circle_outline))
                          ],
                        ),
                      ],
                    ),
                  ));
            },
    );
  }
}
