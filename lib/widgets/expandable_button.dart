import 'package:flutter/material.dart';

class ExpandableButton extends StatefulWidget {
 final  String buttonText;
 final Widget widgetChild;
  const ExpandableButton({super.key,required this.buttonText,required this.widgetChild});

  @override
  State<ExpandableButton> createState() => _ExpandableButtonState();
}

class _ExpandableButtonState extends State<ExpandableButton> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),

      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Send a feed back"),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:widget.widgetChild,
        ),
      ],
    );
  }
}

