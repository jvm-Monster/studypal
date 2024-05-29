// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: (json['id'] as num?)?.toInt(),
      sessionName: json['sessionName'] as String,
      dateTime: json['dateTime'] as String,
      isCanceled: (json['isCanceled'] as num).toInt(),
      targetTime: json['targetTime'] as String,
      canceledTime: json['canceledTime'] as String?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'sessionName': instance.sessionName,
      'dateTime': instance.dateTime,
      'isCanceled': instance.isCanceled,
      'targetTime': instance.targetTime,
      'canceledTime': instance.canceledTime,
    };
