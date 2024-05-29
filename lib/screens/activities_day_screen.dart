import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studypal/app_states/schedule_lists_notifier.dart';
import 'package:studypal/app_states/session_notifier.dart';
import 'package:studypal/models/schedule_task.dart';
import 'package:studypal/models/session.dart';
import 'package:studypal/util/next_schedule_tasks.dart';

class ActivityDayScreen extends ConsumerStatefulWidget {
  const ActivityDayScreen({super.key});

  @override
  ConsumerState createState() => _ActivityDayScreenState();
}

class _ActivityDayScreenState extends ConsumerState<ActivityDayScreen> {
  final now = DateTime.now();
  final dateFormat = DateFormat('EEEE MMMM d yyyy');

  @override
  Widget build(BuildContext context) {
    final formattedDate = dateFormat.format(now);
     final watchListOfSchedules = ref.watch(scheduleListNotifierProvider);
     final watchSessionListProvider = ref.watch(sessionNotifiierProvider);
    return Scaffold(
        appBar: AppBar(
            title: const Text("All Months", style: TextStyle(fontSize: 15))),
        body :watchSessionListProvider.when(
          data: (data) {
            int totalSessionForToday = getTodaysFocusSession(data).length;
            int totalSessionMinutesForToday = totalMinutesForSessionToday(data);
            int totalTaskRemaining = 0;
              if(watchListOfSchedules.value !=null){
              List<ScheduleTask> sortedTask = NextScheduleTasks.filterTaskForToday(watchListOfSchedules.value!);
              totalTaskRemaining = sortedTask.length;
              }
             
            return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(formattedDate,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF0088FF).withOpacity(0.4),
                        width: 10.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: 50,
                      child: Text("$totalTaskRemaining",style: const TextStyle(fontSize: 50),)
                    ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Today",
                                style: TextStyle(fontSize: 15),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          infoWidget(
                              title: "Focus Sessions",
                              firstVal: totalSessionForToday.toString(),
                              secondVal: "$totalSessionMinutesForToday m"),
                          infoWidget(
                              title: "Work Time        ",
                              firstVal: "0",
                              secondVal: "0m"),
                        ],
                      ))),
            )
          ],
        );
          }, 
          error: (error, stackTrace) => const Text("An error occured"), 
          loading: () => const Center(child: CircularProgressIndicator()),)
    );
  }

  infoWidget(
      {required String title,
      required String firstVal,
      required String secondVal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        Text(
          firstVal,
          style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
        ),
        Text(
          secondVal,
          style: const TextStyle(fontSize: 12, color: Colors.blueAccent),
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }

  List<Session> getTodaysFocusSession(List<Session> sessions) {
    DateTime today = DateTime.now();
    String todayString =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    return sessions.where((session) {
      if (session.dateTime.isEmpty) {
        
        return false;
      }

      try {
        DateTime sessionDate = DateTime.parse(session.dateTime.split(' ')[0]);
        String sessionDateString =
            "${sessionDate.year}-${sessionDate.month.toString().padLeft(2, '0')}-${sessionDate.day.toString().padLeft(2, '0')}";
        return sessionDateString == todayString;
      } catch (e) {
        
        return false;
      }
    }).toList();
  }


 // Function to calculate the total time of all sessions in the current month
  int totalMinutesForSessionToday(List<Session> sessions) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int currentDay = now.day;
    int currentMonth = now.month;

    // Filter sessions for the current month
    List<Session> sessionsForMonth = sessions.where((session) {
      if (session.targetTime.isEmpty) {
        return false;
      }

      try {
        DateTime sessionDate =
            DateTime.parse(session.dateTime); // Ensure date is parsed correctly
        return sessionDate.year == currentYear &&
            sessionDate.day == currentDay && sessionDate.month==currentMonth;
      } catch (e) {
       
        return false;
      }
    }).toList();

    // Calculate total duration in minutes
    int totalMinutes = sessionsForMonth.fold(0, (prev, session) {
      try {
        Duration sessionDuration = convertStringToDuration(
            session.targetTime); // Assuming targetTime is the duration
        return prev + sessionDuration.inMinutes;
      } catch (e) {
       
        return prev;
      }
    });

    return totalMinutes;
  }

// Function to convert session duration string to Duration object
  Duration convertStringToDuration(String durationString) {
    try {
      List<String> parts = durationString.split(
          ':'); //index 2 would have a seconds that is like this 00.000000 and so on
      List<String> secondsSplit = parts[2].split(
          '.'); //we want to split that seconds and get only the integer and drop it's decimal
      print('printing $secondsSplit');

      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(secondsSplit[0]);
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      print("Invalid duration format: $durationString");
      return Duration.zero;
    }
  }
}
