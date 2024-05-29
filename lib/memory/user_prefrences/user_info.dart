import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memory/user_prefrences/shared_prefrence_services.dart';
import 'package:studypal/screens/screen_wrapper.dart';

class UserInfo {
  String userName;
  String userPassword;
  static late SharedPreferences _preferences;
  UserInfo({required this.userName, required this.userPassword});




  saveUserName(){
       _preferences = SharedPreferencesService.preferences;
        String? userN = _preferences.getString("username");
        if(userN==null||userN.isEmpty){
             _preferences.setString("username",userName);
        }
  }

  saveUserPassword(){

    _preferences = SharedPreferencesService.preferences;
    String? userPassword = _preferences.getString("userpassword");
    if(userPassword==null||userPassword.isEmpty){
       _preferences.setString("userpassword",userName);
    }
      
  }


   
 
  int? getFirstTimeUse(){
     _preferences = SharedPreferencesService.preferences;
     int? firstTimeUse = _preferences.getInt("spal_fistTimeUse");
     return firstTimeUse;
  }

   void setFirstTimeUse(){
     _preferences = SharedPreferencesService.preferences;
    _preferences.setInt("spal_fistTimeUse",1);
  }


 

  Future<bool> verifyPassword()async {

      _preferences = SharedPreferencesService.preferences;
    String? uName = _preferences.getString("username");
    String? uP = _preferences.getString("userpassword");

    if(uName!=null && uP!=null){
      if(uName == userName && uP==userPassword){
            return true;
        }else{
          return false;
        }
    }
     
     return false;
  }

   
  

  static Future<bool> updatePassword(String userName,String newP)async{
  _preferences = SharedPreferencesService.preferences;
  bool success = await _preferences.setString("userpassword", newP);
  return success;
  }

  
  static updateUserName(String newUserName,ref)async{
  _preferences = SharedPreferencesService.preferences;
 
  bool success = await _preferences.setString("username", newUserName);
   if(success){
    ref.read(userNameProvider.notifier).update((state)=>newUserName);
   }
  }
}