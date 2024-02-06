import 'package:flutter/material.dart';

class DayButtonWidget extends StatelessWidget {
  final Function(String text) doFunction;
  final String text;

  const DayButtonWidget({super.key, required this.text, required this.doFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: doFunction(text),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 50),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text.substring(0, 3),
                style: const TextStyle(
                  color: Color(0xff0088FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
