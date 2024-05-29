import 'package:flutter/material.dart';

class Course {
  late String title;
  late String selectedDay;
  late TimeOfDay remindMeAt;
  late int scheduleId;
  late String description;
  late String lead;

  Course(this.title, this.selectedDay, this.remindMeAt, this.scheduleId,
      this.description, this.lead);

  @override
  String toString() {
    return 'Course{title: $title, selectedDay: $selectedDay, remindMeAt: $remindMeAt, scheduleId: $scheduleId, description: $description, lead: $lead}';
  }
}
