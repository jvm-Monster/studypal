import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/memeory/shared_prefrence_services.dart';
import 'package:studypal/notification_controller.dart';
import 'package:studypal/screens/screen_wrapper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:timezone/data/latest.dart';
import 'package:app_settings/app_settings.dart';


import 'models/plan_days.dart';
import 'models/study.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: "StudyPal_channel_group",
            channelKey: "studypal_channel",
            channelName:"StudyPal Notification",
            channelDescription:  "StudyPal notifications channel",
            playSound: true,
            enableVibration: true,
            channelShowBadge: true,

        )
      ],
    channelGroups: [
      NotificationChannelGroup(
          channelGroupKey:"studypal_channel_group",
          channelGroupName: "StudyPal Group"
      )
    ]
  );
  await SharedPreferencesService.initialize();
 /* runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(), // Wrap your app
      ) ,
    )
  );*/
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }
/*
AwesomeNotifications().showNotificationConfigPage();*/

  runApp(
      const ProviderScope(
        child: MyApp(),
      )
  );
 }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(
              0xff0088FF,
            ),
            brightness: Brightness.dark),
      ),
      home: const ScreenWrapper(),
    );
  }
}

