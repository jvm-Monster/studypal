import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studypal/memeory/save_plan_to_memory.dart';
import 'package:studypal/memeory/shared_prefrence_services.dart';
import 'package:studypal/screens/home_screen.dart';
import 'package:device_preview/device_preview.dart';

import 'models/plan_days.dart';
import 'models/study.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.initialize();
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true,
        builder: (context) => const MyApp(), // Wrap your app
      ) ,
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(
              0xff0088FF,
            ),
            brightness: Brightness.dark),
      ),
      home: const BottomNavigationScreen(),
    );
  }
}
