import 'package:studypal/models/plan_days.dart';

class Plan {
  String planName;
  String planDescription;
  PlanDays? planDays;
  Plan({required this.planName, required this.planDescription,this.planDays}){
    planDays ??= PlanDays([], [], [], [], [], [], []);
  }

  // Convert StudyPlan to Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'planName':planName,
      'planDescription': planDescription,
      'planDays':planDays?.toMap()
    };
  }

  // Create StudyPlan from Map during deserialization
  factory Plan.fromMap(Map<String, dynamic> map) {
    PlanDays? planDays=PlanDays.fromMap(map['planDays']);
    return Plan(
      planName: map['planName'],
      planDescription: map['planDescription'],
      planDays: planDays,
    );
  }


  @override
  String toString() {
    return 'Plan{task: $planName, planDescription: $planDescription, planDays: $planDays}';
  }



}
