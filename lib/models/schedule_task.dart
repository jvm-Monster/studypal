import 'package:json_annotation/json_annotation.dart';

part 'schedule_task.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduleTask {
  int? id;
  String name;
  String? description;
  String? lead;
  String dueDate;
  String day;
  int? completed;
  int scheduleId;

  ScheduleTask(
      {this.id,
      required this.name,
      this.description,
      this.lead,
      required this.day,
      required this.dueDate,
      this.completed,
      required this.scheduleId});

  factory ScheduleTask.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTaskFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTaskToJson(this);

  @override
  String toString() {
    return 'ScheduleTask{id: $id, name: $name, description: $description, lead: $lead, dueDate: $dueDate, day: $day, completed: $completed, scheduleId: $scheduleId}';
  }
}
