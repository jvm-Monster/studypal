import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/widgets/show_plan_widget.dart';

class DayButtonWidget extends StatelessWidget {

  final String text;

  const DayButtonWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: (){
            ref.read(selectedDayProvider.notifier).update((state) => text);
          },
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
      },

    );
  }
}
