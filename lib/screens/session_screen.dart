import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:studypal/app_states/session_notifier.dart';
import 'package:studypal/memory/database/session_database_helper.dart';
import 'package:studypal/models/session.dart';
import 'package:studypal/screens/screen_wrapper.dart';
import 'package:studypal/service/notification_service.dart';

final counterPausedProvider = StateProvider<bool>((ref) => true);
final createASessionProvider = StateProvider<bool>((ref)=>false);
final errorStateProvider = StateProvider<bool>((ref)=>false);
final sessionProvider = StateProvider<Session?>((ref)=>null);
final sessionProviderWatcher = StateProvider<Session?>((ref)=>ref.watch(sessionProvider));
class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  ConsumerState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  late final StreamDuration streamDuration;
  TextEditingController nameSessionTextEditingController = TextEditingController();
 

   Function? onDoneStreamDuration(){
     Session? ses = ref.read(sessionProviderWatcher.notifier).state;
     if(ses!=null){
      NotificationService().showNotification(title: ses.sessionName,body: "session has been completed");
      ref.read(sessionNotifiierProvider.notifier).createSession(ses);
           ref.watch(sessionProvider.notifier).update((state) => null,);
            ref.read(streamDurationFinishedProvider.notifier).update((state) => true,); 
             ref.read(createASessionProvider.notifier).update((state) => false,);
              
   
     }
    
     return null;
  }
  @override
  void initState() {
    super.initState();
    streamDuration = StreamDuration(
      config: StreamDurationConfig(
        autoPlay: false,
        countDownConfig: const CountDownConfig(
          duration: Duration(hours: 1, minutes: 1, seconds: 1),
          
        ),
        onDone:onDoneStreamDuration
      ),
    );
  }

  Future<void> _pickTime(Session? session) async {
    streamDuration.pause();
    ref.read(counterPausedProvider.notifier).update((state) => true,);
    TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
         builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },

    );
    if (newTime != null && session!=null) {
      Duration newDuration = Duration(
        hours: newTime.hour,
        minutes: newTime.minute,
      );
        
        
        streamDuration.change(newDuration);
        session.setTargetTime(newDuration.toString());
        streamDuration.play();
        ref.read(counterPausedProvider.notifier).update((state) => false,);
        ref.read(sessionProvider.notifier).update((state) => session,);
        ref.read(createASessionProvider.notifier).update((state) => false,);
       
    }
  }

  Future<bool> _onWillPop(bool didPop) async {
    bool? shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancel Session?'),
          content: const Text(
            'You have made significant progress. Cancelling now means you won’t complete your task. Are you sure you want to cancel the session?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No, Continue'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
    return shouldCancel ?? false;
  }

  @override
  void dispose() {
    streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCounterPaused = ref.watch(counterPausedProvider);
    final watchCreateASessionProvider = ref.watch(createASessionProvider);
    final watchErrorStateProvider = ref.watch(errorStateProvider);
    final watchSessionProvider = ref.watch(sessionProvider);
  
    return PopScope(
      onPopInvoked: _onWillPop,
      child:  SafeArea(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              const Row(
                children: [
                  Padding(
                     padding: EdgeInsets.all(8.0),
                     child: Text("Focus Session",style: TextStyle(fontSize: 20),),
                   ),
                ],
              ),
              const SizedBox(height: 50,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(watchCreateASessionProvider){
                            _pickTime(watchSessionProvider);
                        }else{
                            ref.read(errorStateProvider.notifier).update((state) => !watchErrorStateProvider,);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF0088FF).withOpacity(0.4),
                            width: 10.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          maxRadius: 140,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SlideCountdown(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0088FF),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                streamDuration: streamDuration,
                                slideDirection: SlideDirection.up,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text("Next Up: Focus"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:   TextField(
                        controller: nameSessionTextEditingController,
                        cursorOpacityAnimates: true,
                        onSubmitted: (value) {
                          DateTime time = DateTime.now();
                          
                          Session session = Session(
                            sessionName: value, 
                            dateTime: time.toString(), 
                            isCanceled: 0, 
                            targetTime: streamDuration.config.countDownConfig!.duration.toString(),
                            
                          );
                          ref.read(sessionProvider.notifier).update((state) => session,);
                          ref.read(createASessionProvider.notifier).update((state) => true,);
                          ref.read(errorStateProvider.notifier).update((state) => false,);
                          
                        },
                        decoration:InputDecoration(
                          isDense: true,
                          labelStyle: watchErrorStateProvider?const TextStyle(color: Colors.red):const TextStyle(color: Colors.grey),
                          labelText: watchErrorStateProvider?"Create a session first":"Name Session",
                          
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (isCounterPaused) {
                
                               
                              if(watchCreateASessionProvider){
                                    streamDuration.play();
                                    ref.read(counterPausedProvider.notifier).state = false;
                              }else{
                                 ref.read(errorStateProvider.notifier).state = true;
                              }
                             
                
                            } else {
                              streamDuration.pause();
                              ref.read(counterPausedProvider.notifier).state = true;
                            }
                          },
                          icon: Icon(
                            isCounterPaused
                                ? CupertinoIcons.play_circle_fill
                                : CupertinoIcons.pause_circle_fill,
                            size: 50,
                            color: const Color(0xFF9E9E9E),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
     
    );
  }
}
