import 'package:json_annotation/json_annotation.dart';
import 'package:studypal/models/schedule_task.dart';

part 'schedule.g.dart';

@JsonSerializable(explicitToJson: true)
class Schedule {
  int? id;
  String name;
  List<ScheduleTask>? scheduleTasks = [];

  Schedule({this.id, required this.name});

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  @override
  String toString() {
    return 'Schedule{id: $id, name: $name, scheduleTasks: $scheduleTasks}';
  }
}
