import 'package:flutter/material.dart';

class DayButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final bool isSelected;

  const DayButtonWidget(
      {super.key,
      required this.text,
      required this.function,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 50),
          child: Card(
            color: isSelected ? const Color(0xff0088FF) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text.substring(0, 1),
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xff0088FF),
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
