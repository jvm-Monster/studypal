import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable(explicitToJson: true)
class Session {
  int? id;
  final String sessionName;
  final String dateTime;
  int isCanceled;
  String targetTime;
  String? canceledTime;

  Session({
    this.id,
    required this.sessionName,
    required this.dateTime,
    required this.isCanceled,
    required this.targetTime,
    this.canceledTime,
  });

  // A necessary factory constructor for creating a new Session instance from a map.
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  // A necessary method which converts this class instance to a map.
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  setIsCanceled(int val){
    isCanceled = val;
  }

  setCanceledTime(String time){
    canceledTime=time;
  }

  setTargetTime(String tagTime){
      targetTime = tagTime;
  }



  @override
  String toString() {
    return 'Session{id: $id, sessionName: $sessionName, dateTime: $dateTime, isCanceled: $isCanceled, targetTime: $targetTime, canceledTime: $canceledTime}';
  }
}
