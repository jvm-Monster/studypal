import 'package:flutter/material.dart';

class HomeButtonsWidget extends StatelessWidget {
  final String name;
  final Icon icon;
  final VoidCallback? function;

  const HomeButtonsWidget(
      {super.key, required this.name, required this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: function, icon: icon);
  }
}
