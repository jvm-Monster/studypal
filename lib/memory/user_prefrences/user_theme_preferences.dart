import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/app_states/app_state_providers.dart';
import 'package:studypal/memory/user_prefrences/shared_prefrence_services.dart';

 

class UserThemePreferences {
  static late SharedPreferences _preferences;
  static String keyPreference = "studyPalThemeMode";
  static bool _themeMode = false;
  static bool enableNot = false;

  static Future<void> saveUserThemeMode(bool mode, WidgetRef ref) async {
    _preferences = SharedPreferencesService.preferences;
    _preferences.setBool(keyPreference, mode);

    ref.read(studyPalThemeProvider.notifier).update((state) => mode);
  }

  static Future<bool> enableQuoteNotification(bool enable)async {
    _preferences = SharedPreferencesService.preferences;
    _preferences.setBool("studyPalQuoteNotification", enable);
    return enable;
  }

  static Future<void> prepareQuoteNotificationMode()async{
    _preferences = SharedPreferencesService.preferences;
    enableNot = _preferences.getBool("studyPalQuoteNotification")!;
  }

  static bool getNotificationMode(){
    prepareQuoteNotificationMode();
    return enableNot;
  }


  static Future<void> _setThemeMode() async {
    _preferences = SharedPreferencesService.preferences;
    bool? mode = _preferences.getBool(keyPreference);
    if (mode != null) {
      _themeMode = mode;
    }
  }

  static bool getUserThemeMode() {
    _setThemeMode();
    return _themeMode;
  }
}
