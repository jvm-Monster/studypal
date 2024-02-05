import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorPicker extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.purpleAccent,
    Colors.green,
    Colors.green,
    Colors.yellow,
    Colors.blue, // I assume you meant Colors.blue instead of Colors.blu
  ];

  RandomColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final Color randomColor = colors[random.nextInt(colors.length)];

    return  Container(
      width: 5,
      height: 45,

      decoration: BoxDecoration(
          color: randomColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}
