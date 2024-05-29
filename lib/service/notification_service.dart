import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studypal/service/quote_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  // on tap on any notification

  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    tz.initializeTimeZones();

    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
            playSound: true,
            priority: Priority.max));
  }

  Future showNotification({int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> scheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
    required DateTime scheduledDate,
  }) async {
    tz.setLocalLocation(tz.getLocation('Africa/Lagos'));

    // Ensure scheduledDate is in the correct timezone
    tz.TZDateTime scheduledDateTime = tz.TZDateTime.local(
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        scheduledDate.hour,
        scheduledDate.minute);
    // Schedule the notification
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id', // Change to your channel ID
          'Your Channel Name', // Change to your channel name
          importance: Importance.max,
          playSound: true,
          priority: Priority.max,
          sound: RawResourceAndroidNotificationSound("res_custom_notification"),
          // Custom sound
          enableVibration: true,
          category: AndroidNotificationCategory.alarm,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }


  static cancelNotification(int notificationId) async {
    notificationsPlugin.cancel(notificationId);
  }



  Future<void> periodicQuoteNotification()async {
    /*
    * Get a list of alarms for that day at least 5 quotes per day
    * schedule each quote notification for that day
    *
    * */
    // So first thing get a list of quotes
 
    for(int i = 0; i<5;i++){
      Map<String,dynamic> quote = await QuoteService.getQuoteForTheDay();
      if(quote.isNotEmpty){
         quoteScheduleNotification(id: i, body: quote['body']);
      }
    }
  }

  Future<void> quoteScheduleNotification({required int id, required String body,})async{
    
      tz.TZDateTime scheduledDateTime = tz.TZDateTime.now(tz.local)
      .add(Duration(hours:2+id));

    await notificationsPlugin.zonedSchedule(
      id,
      "Motivate your day ",
      body,
      scheduledDateTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'quote notification2', // Change to your channel ID
          'Your Channel Name', // Change to your channel name
          playSound: true,
          priority: Priority.low,
          // sound: RawResourceAndroidNotificationSound("res_custom_notification"),
          // // Custom sound
          // enableVibration: true,
          colorized: true,
          category: AndroidNotificationCategory.message,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelQuoteNotificaiton(){
      for(int i =0;i<5;i++){
        NotificationService.cancelNotification(i);
      }
  }
}
