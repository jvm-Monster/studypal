// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    )..scheduleTasks = (json['scheduleTasks'] as List<dynamic>?)
        ?.map((e) => ScheduleTask.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'scheduleTasks': instance.scheduleTasks?.map((e) => e.toJson()).toList(),
    };
