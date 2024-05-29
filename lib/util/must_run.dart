import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'package:studypal/app_states/app_state_providers.dart';
import 'package:studypal/memory/user_prefrences/quote_cache.dart';
import 'package:studypal/memory/user_prefrences/shared_prefrence_services.dart';
import 'package:studypal/memory/user_prefrences/user_theme_preferences.dart';

import '../service/notification_service.dart';

class MustRun {
  static Future<void> mustRun() async {
    await SharedPreferencesService.initialize();
    //await NotificationService.initializeNotification();
    NotificationService().initNotification();
    enableNotificationCheck();
    QuoteCache.initializeQuoteCache();
   
    //await Alarm.init();
  }

  static void runUserThemePreferences(WidgetRef ref) async {
    bool ss = UserThemePreferences.getUserThemeMode();
    ref.read(studyPalThemeProvider.notifier).update((state) => ss);
  }

  static void enableNotificationCheck()async{
    bool enabled = UserThemePreferences.getNotificationMode();
    print("quote enabled $enabled");
    if(enabled){
      NotificationService().periodicQuoteNotification();
    }else{
     NotificationService.cancelQuoteNotificaiton();
    }
  }
}
