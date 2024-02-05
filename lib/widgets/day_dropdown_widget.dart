import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DayDropDownWidget extends ConsumerStatefulWidget {
  const DayDropDownWidget({super.key});

  @override
  ConsumerState createState() => _DayDropDownWidgetState();
}

class _DayDropDownWidgetState extends ConsumerState<DayDropDownWidget> {
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  // Variable to store the selected day
  String selectedDay = 'Monday';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      hint: const Text("Pick A Day"),
      value: selectedDay,
      onChanged: (String? newValue) {
        setState(() {
          selectedDay = newValue!;
        });
      },
      items: daysOfWeek.map((String day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Text(day),
        );
      }).toList(),
    );
  }
}
