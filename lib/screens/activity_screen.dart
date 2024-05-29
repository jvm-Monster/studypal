import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studypal/app_states/session_notifier.dart';
import 'package:studypal/models/session.dart';
import 'package:studypal/screens/activities_day_screen.dart';
import 'package:studypal/widgets/activities_info_widget.dart';
import 'package:studypal/widgets/pill_button.dart';

class ActivityScreen extends ConsumerStatefulWidget {
  final String? screenTitle;
  const ActivityScreen({super.key, this.screenTitle});

  @override
  ConsumerState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  final now = DateTime.now();
  final dateFormat = DateFormat('yyyy ');
  final monthFormattedDate = DateFormat('MMMM');

  @override
  Widget build(BuildContext context) {
    final formattedDate = dateFormat.format(now);
    final month = monthFormattedDate.format(now);
    final watchSessionListProvider = ref.watch(sessionNotifiierProvider);
     
    return watchSessionListProvider.when(
      data: (List<Session> data) {
        int todayCount = getCurrentMonthSessions(data).length;
        int totalMinutes = totalMinutesForFocusSessionInAMonth(data);
        

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Padding(
               padding: EdgeInsets.all(8.0),
               child: Text("All Months",style: TextStyle(fontSize: 20),),
             ),
              panelWidget(formattedDate),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              month,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ActivityDayScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                        ActivitiesInfoWidget(
                          title: Text(
                            "Focus Session",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          firstVal: Text(
                            todayCount.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          secondVal: Text(
                            "$totalMinutes m",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        // ActivitiesInfoWidget(
                        //   title: Text(
                        //     "Work Time",
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.grey[700],
                        //     ),
                        //   ),
                        //   firstVal: Text(
                        //     "0",
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.grey[700],
                        //     ),
                        //   ),
                        //   secondVal: Text(
                        //     "Om",
                        //     style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.grey[700],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              PillButton(
                sessions: data,
              )
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return const Text("An error occurred");
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  panelWidget(formattedDate) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 15),
          ),
          const Text(
            "Total",
            style: TextStyle(fontSize: 15),
          ),
          const Text(
            "Average",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  day(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 2,
          width: 25,
          color: Colors.blueAccent,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(text),
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

  List<Session> getCurrentMonthSessions(List<Session> sessions) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int currentMonth = now.month;

    return sessions.where((session) {
      if (session.dateTime.isEmpty) {
        print(
            "Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }

      try {
        DateTime sessionDate = DateTime.parse(session.dateTime);
        return sessionDate.year == currentYear &&
            sessionDate.month == currentMonth;
      } catch (e) {
        print(
            "Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }
    }).toList();
  }

  // Function to calculate the total time of all sessions in the current month
  int totalMinutesForFocusSessionInAMonth(List<Session> sessions) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
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
            sessionDate.month == currentMonth;
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
     

      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);
      int seconds = int.parse(secondsSplit[0]);
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
 
      return Duration.zero;
    }
  }
}
