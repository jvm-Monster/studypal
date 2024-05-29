import 'package:flutter/material.dart';

class AddCourseStatusSnackBar extends SnackBar {
  final Color? bgColor;

  const AddCourseStatusSnackBar(
      {super.key, required super.content, this.bgColor});

  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor,

      duration: const Duration(seconds: 3), // Adjust duration as needed
    );
  }
}
