import 'package:flutter/material.dart';

class ActivitiesInfoWidget extends StatefulWidget {
  final Text title;
  final Text firstVal;
  final Text secondVal;
 
  const ActivitiesInfoWidget(
      {super.key,
      required this.title,
      required this.firstVal,
      required this.secondVal,
      });

  @override
  State<ActivitiesInfoWidget> createState() => _ActivitiesInfoWidgetState();
}

class _ActivitiesInfoWidgetState extends State<ActivitiesInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: widget.title),
        Flexible(
          flex: 2,
          child: widget.firstVal),
        widget.secondVal,
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
