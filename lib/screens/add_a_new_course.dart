import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/models/course.dart';
import 'package:studypal/screens/course_day_screen.dart';

import '../widgets/checkbox_day_list.dart';

class AddANewCourse extends ConsumerStatefulWidget {
  final int scheduleId;
  final String selectedDay;

  const AddANewCourse(
      {super.key, required this.scheduleId, required this.selectedDay});

  @override
  ConsumerState createState() => _AddANewCourseState();
}

class _AddANewCourseState extends ConsumerState<AddANewCourse> {
  TextEditingController titleTextEditController = TextEditingController();
  TextEditingController descriptionTextEditController = TextEditingController();
  TextEditingController leadTextEditController = TextEditingController();
  TimeOfDay remindMeAt = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new course"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                cursorOpacityAnimates: true,
                controller: titleTextEditController,
                onSubmitted: (value) {},
                decoration: const InputDecoration(
                  isDense: true,
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "example(course name)",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionTextEditController,
                maxLines: 3,
                cursorOpacityAnimates: true,
                onSubmitted: (value) {},
                decoration: const InputDecoration(
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: leadTextEditController,
                cursorOpacityAnimates: true,
                onSubmitted: (value) {},
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Add a Lecturer, Lead, Speaker(etc)",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Course course = Course(
                            titleTextEditController.text,
                            widget.selectedDay,
                            remindMeAt,
                            widget.scheduleId,
                            descriptionTextEditController.text,
                            leadTextEditController.text);
                        ref
                            .read(checkBoxAlarmProvider.notifier)
                            .update((state) => {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectCourseDayScreen(
                                course: course,
                              ),
                            ));
                      },
                      child: const Text("Add course")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

/*SubmitScheduledTaskUtil.submitTask(v, watchSelectedDay, remindMeAt, ref, scheduleId);*/
}
