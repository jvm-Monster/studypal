import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task {
  int? id;
  String name;
  String description;
  String dueDate;
  int priority;
  int completed;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.dueDate,
    this.priority = 0,
    this.completed = 0,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  String toString() {
    return 'Task{id: $id, name: $name, description: $description, dueDate: $dueDate, priority: $priority, completed: $completed}';
  }
}
