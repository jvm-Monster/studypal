import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_state_providers.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/models/plan_days.dart';
import 'package:studypal/widgets/show_plan_widget.dart';

import '../models/study.dart';

class ViewPlanListWidget extends ConsumerStatefulWidget {
  const ViewPlanListWidget({super.key});

  @override
  ConsumerState createState() => _ViewPlanListWidgetState();
}

class _ViewPlanListWidgetState extends ConsumerState<ViewPlanListWidget> {
  @override
  Widget build(BuildContext context) {
    final planListWatch = ref.watch(getPlanListProvider);
    return ListView.builder(
        itemCount: planListWatch.length,
        itemBuilder: (context, index) {
          Plan plan = planListWatch[index];
          return ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPlanWidget(planSelectedIndex: index,),));
            },

            title: Text(plan.planName),
            subtitleTextStyle: const TextStyle(
                color: Colors.grey
            ),
            subtitle: Text(plan.planDescription),
            trailing: PopupMenuButton<int>(
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Edit'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: const Text('Delete'),
                  onTap: ()async {

                    // Handle Delete action
                    bool success  = await SavePlanToMemory.removePlan(index);
                    if(success){
                      final List<Plan> updatedList = List.from(planListWatch);
                      updatedList.removeAt(index);
                      ref.read(getPlanListProvider.notifier).update((state) => updatedList);
                    }
                  },
                ),
                // Add more options as needed
              ],
              onSelected: (value) {
                // Handle the selected option
                if (value == 0) {
                  // Handle Edit action
                } else if (value == 1) {
                  // Handle Delete action
                }
                // Add more cases if needed
              },
            ),
          );
        },
    );
  }
}
