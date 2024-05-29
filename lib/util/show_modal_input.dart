import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowModalInputField {
  static void showAddScheduleSheet(BuildContext context,
      {required TextEditingController textEditingController,
      String? inputLabelText,
      int? val,
      int? scheduleId,
      required WidgetRef ref,
      VoidCallback? onSetTimeClick,
      Function(String value)? onSubmitted}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
      constraints: const BoxConstraints(minHeight: 100),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    cursorOpacityAnimates: true,
                    onSubmitted: onSubmitted,
                    decoration: InputDecoration(
                        labelText: inputLabelText,
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
