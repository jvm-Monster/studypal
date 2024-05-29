import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/widgets/scheduler_widgets/list_of_schedule_tasks_widget.dart';

import 'day_button_widget.dart';

final List<String> daysOfTheWeek = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
];
final _isSelectedDayState = StateProvider((ref) => "Monday");

class DaysOfTheWeekWidget extends ConsumerStatefulWidget {
  final String scheduleName;

  const DaysOfTheWeekWidget({super.key, required this.scheduleName});

  @override
  ConsumerState createState() => _DaysOfTheWeekWidgetState();
}

class _DaysOfTheWeekWidgetState extends ConsumerState<DaysOfTheWeekWidget> {
  @override
  Widget build(BuildContext context) {
    final isSelectedDay = ref.watch(_isSelectedDayState);
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff0088FF).withOpacity(0.05),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.scheduleName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysOfTheWeek
                  .map((day) => DayButtonWidget(
                        text: day,
                        function: () {
                          ref
                              .read(selectedDayProvider.notifier)
                              .update((state) => day);
                          ref
                              .read(_isSelectedDayState.notifier)
                              .update((state) => day);
                        },
                        isSelected: (isSelectedDay == day) ? true : false,
                      ))
                  .toList(),
            ),
          ])),
    );
  }
}
