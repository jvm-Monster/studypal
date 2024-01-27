import 'package:flutter/material.dart';

class TimeInputWidget extends StatefulWidget {
  @override
  _TimeInputWidgetState createState() => _TimeInputWidgetState();
}

class _TimeInputWidgetState extends State<TimeInputWidget> {
  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();
  TextEditingController _secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Hour TextField
        SizedBox(
          width: 80,
          child: TextField(
            controller: _hourController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Hours'),
          ),
        ),

        // Minute TextField
        SizedBox(
          width: 80,
          child: TextField(
            controller: _minuteController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Minutes'),
          ),
        ),

        // Second TextField
        SizedBox(
          width: 80,
          child: TextField(
            controller: _secondController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Seconds'),
          ),
        ),
      ],
    );
  }

  // You can use these controllers to get the user-inputted values when needed
  int get hours => int.tryParse(_hourController.text) ?? 0;
  int get minutes => int.tryParse(_minuteController.text) ?? 0;
  int get seconds => int.tryParse(_secondController.text) ?? 0;
}
