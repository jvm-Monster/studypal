import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memeory/shared_prefrence_services.dart';

import '../models/study.dart';

class SavePlanToMemory {
  static late SharedPreferences _preferences;

  static Future<bool> addPlan({required Plan plan, int? index}) async {
    try {
      _preferences = SharedPreferencesService.preferences;
      List<String> encodedPlans = _preferences.getStringList("plans") ?? [];

      if (index !=null && (index>-1 && index<encodedPlans.length)) {
          encodedPlans[index] = jsonEncode(plan.toMap());
      } else {
        encodedPlans.add(jsonEncode(plan.toMap()));
      }

      _preferences.setStringList("plans", encodedPlans);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removePlan(int index) async {
    try {
      _preferences = SharedPreferencesService.preferences;

      List<String> encodedPlans = _preferences.getStringList("plans") ?? [];

      if (index >= 0 && index < encodedPlans.length) {
        encodedPlans.removeAt(index);
        _preferences.setStringList("plans", encodedPlans);
        return true;
      }

      // Handle invalid index, or ignore if needed
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Plan>> getAllPlans() async {
    _preferences = SharedPreferencesService.preferences;
    List<String> encodedPlans = _preferences.getStringList("plans") ?? [];

    if (encodedPlans.isEmpty) {
      return [];
    }

    // Convert the list of encoded plans back to Plan objects
    List<Plan> decodedPlans = encodedPlans.map((pln) {
      Map<String, dynamic> map = jsonDecode(pln);
      return Plan.fromMap(map);
    }).toList();

    return decodedPlans;
  }

  static Future<bool> removeATask(int planIndex,String day,int taskIndex)async{
    bool success = false;
    _preferences = SharedPreferencesService.preferences;
    List<String> encodedPlans = _preferences.getStringList("plans") ?? [];


    // Convert the list of encoded plans back to Plan objects
    List<Plan> decodedPlans = encodedPlans.map((pln) {
      Map<String, dynamic> map = jsonDecode(pln);
      return Plan.fromMap(map);
    }).toList();

    if(decodedPlans.isNotEmpty){
      Plan plan = decodedPlans[planIndex];
      switch(day){
        case 'Monday':plan.planDays?.monday.removeAt(taskIndex);success=true;break;
        case 'Tuesday':plan.planDays?.tuesday.removeAt(taskIndex);success=true;break;
        case 'Wednesday':plan.planDays?.wednesday.removeAt(taskIndex);success=true;break;
        case 'Thursday':plan.planDays?.thursday.removeAt(taskIndex);success=true;break;
        case 'Friday':plan.planDays?.friday.removeAt(taskIndex);success=true;break;
        case 'Saturday':plan.planDays?.saturday.removeAt(taskIndex);success=true;break;
        case 'Sunday':plan.planDays?.sunday.removeAt(taskIndex);success=true;break;
      }

      String encodedPlan = jsonEncode(plan.toMap());
      encodedPlans[planIndex]=encodedPlan;

      _preferences.setStringList("plans", encodedPlans);

      return success;
    }

    print('This is failure');
    return success;
  }

}
