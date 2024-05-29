// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleTask _$ScheduleTaskFromJson(Map<String, dynamic> json) => ScheduleTask(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      lead: json['lead'] as String?,
      day: json['day'] as String,
      dueDate: json['dueDate'] as String,
      completed: (json['completed'] as num?)?.toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
    );

Map<String, dynamic> _$ScheduleTaskToJson(ScheduleTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'lead': instance.lead,
      'dueDate': instance.dueDate,
      'day': instance.day,
      'completed': instance.completed,
      'scheduleId': instance.scheduleId,
    };
