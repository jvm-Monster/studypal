import 'package:flutter/material.dart';

class RandomColorPicker extends StatelessWidget {
  final int scheduleTaskIndex;

  RandomColorPicker({super.key, required this.scheduleTaskIndex});

  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.purpleAccent,
    Colors.grey,
    Colors.green,
    Colors.yellow,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    final Color randomColor = colors[scheduleTaskIndex];

    return Container(
      height: 5,
      decoration: BoxDecoration(
          color: randomColor,
          borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20),
              bottomStart: Radius.circular(20))),
    );
  }
}
