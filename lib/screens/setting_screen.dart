import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/app_states/app_state_providers.dart';
import 'package:studypal/screens/privacy_policy_screen.dart';
import 'package:studypal/service/notification_service.dart';
import 'package:studypal/util/navigator_animator.dart';
import 'package:studypal/widgets/expandable_button.dart';
 
import '../memory/user_prefrences/user_theme_preferences.dart';
import '../service/quote_service.dart';

final enableQuoteNotificationProvider = StateProvider(
  (ref) {
    return UserThemePreferences.getNotificationMode();
  },
);

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  Map<String, dynamic>? _quote;
  String _errorMessage = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchQuote();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _fetchQuote();
    });
  }

  Future<void> _fetchQuote() async {
    try {
      final quote = await QuoteService.getQuoteForTheDay();
      setState(() {
        _quote = quote;
        _errorMessage = '';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load quote';
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool enableMotivationalQuote = false;
  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(studyPalThemeProvider);
    final enableNotification = ref.watch(enableQuoteNotificationProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Settings"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          UserThemePreferences.saveUserThemeMode(!mode, ref);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              mode!
                                  ? const Text("Dark mode")
                                  : const Text("Light mode"),
                              Icon(
                                mode ? Icons.dark_mode : Icons.light_mode,
                                size: 40,
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        bool enabled =
                            await UserThemePreferences.enableQuoteNotification(
                                !enableNotification);
                        if (enabled) {
                          showD();
                        } else {
                          NotificationService.cancelQuoteNotificaiton();
                        }
                        ref.read(enableQuoteNotificationProvider.notifier).update(
                              (state) => enabled,
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Quote notification"),
                          Switch(
                            value: enableNotification,
                            onChanged: (value) async {
                              bool enabled = await UserThemePreferences
                                  .enableQuoteNotification(value);
                              if (enabled) {
                                showD();
                              } else {
                                NotificationService.cancelQuoteNotificaiton();
                              }
                              ref
                                  .read(enableQuoteNotificationProvider.notifier)
                                  .update(
                                    (state) => enabled,
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          NavigatorAnimator.animateNavigateTor(
                              context, const PrivacyPolicyScreen());
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Privacy Policy"),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 40,
                              )
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    ExpandableButton(buttonText:"Send a feedback",widgetChild:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          
                        
                        TextField(
                          maxLines: 3,
                          cursorOpacityAnimates: true,
                          onSubmitted: (value) {},
                          decoration: const InputDecoration(
                            isDense: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) {
                                    return  const AlertDialog(
                                      content: Icon(Icons.check_circle,size: 60,color:Colors.green),
                                       
                                    );
                                  },);
                                },
                                child: const Text("Send Feedback")))
                      ],
                    ),),
                    
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  showD() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enable quote notificaiton"),
        content: const Text(
            "When the app is restarted the quote notification will start working"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"),
          )
        ],
      ),
    );
  }
}
