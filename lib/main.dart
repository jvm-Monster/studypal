import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/app_state_providers.dart';
 
import 'package:studypal/memory/database/database_helper.dart';
import 'package:studypal/memory/user_prefrences/user_theme_preferences.dart';
import 'package:studypal/screens/login_screen.dart';
import 'package:studypal/screens/screen_wrapper.dart';
import 'package:studypal/util/must_run.dart';
import 'package:studypal/widgets/study_pal_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await DatabaseHelper.initDatabase();
  await MustRun
      .mustRun(); // Run all necessary configurations before starting the app

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

 

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  late AppLifecycleState _lastLifecycleState;
  final bool userTheme = UserThemePreferences.getUserThemeMode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
    if (state == AppLifecycleState.detached) {}
  }

  @override
  Widget build(BuildContext context) {

    return Consumer(
      builder: (context, ref, child) {
        final mode = ref.watch(studyPalThemeProvider);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: MyApp.navigatorKey,
          title: 'StudyPal',
          theme: mode == null
              ? userTheme == false
                  ? StudyPalTheme.lightTheme()
                  : StudyPalTheme.darkTheme()
              : mode == false
                  ? StudyPalTheme.lightTheme()
                  : StudyPalTheme.darkTheme(),
          home: const ScreenWrapper(),
        );
      },
    );
  }
}
