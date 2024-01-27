import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memeory/shared_prefrence_services.dart';

import '../models/study.dart';

class SavePlanToMemory {
  static late SharedPreferences _preferences;
  static Future<bool> addPlan(Plan plan) async {
    try{
      _preferences=SharedPreferencesService.preferences;
      String pln = jsonEncode(plan.toMap());

      List<String>? plans = _preferences.getStringList("plans");

      if (plans == null) {
        plans = [pln];
      } else {
        print('added it');
        plans.add(pln);
      }
      _preferences.setStringList("plans", plans);
      return true;
    }catch(e){
      return false;
    }

  }

  static Future<bool> removePlan(int index)async{
    try{
      _preferences=SharedPreferencesService.preferences;


      List<String>? plans = _preferences.getStringList("plans");

      if (plans == null) {
       return false;
      }
        print("Removed plan");
        plans.removeAt(index);

      _preferences.setStringList("plans", plans);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<List<Plan>> getAllPlans() async {
    _preferences=SharedPreferencesService.preferences;
    List<String>? plans = _preferences.getStringList("plans");

    if (plans == null) {
      return [];
    }

    // Convert the list of encoded plans back to Plan objects
    List<Plan> decodedPlans = plans.map((pln) {
      Map<String, dynamic> map = jsonDecode(pln);
      Plan plan = Plan.fromMap(map);
      return plan;
    }).toList();

    return decodedPlans;
  }
}
