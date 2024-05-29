import 'package:flutter/material.dart';
import 'package:studypal/models/session.dart';

class PillButton extends StatefulWidget {
  final List<Session> sessions;
  const PillButton({super.key,required this.sessions});

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  String info = "This month";
  String focuss = "";
  
  @override
  void initState() {
    focuss=getCurrentMonthSessions(widget.sessions).length.toString();
    // TODO: implement initState
    super.initState();
  }
  

  int bId = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      pillButton("This month", 0,"This month",getCurrentMonthSessions(widget.sessions).length.toString()),
                      pillButton("This week", 1,"This week",getCurrentWeekSessions(widget.sessions).length.toString()),
                      pillButton("Last 10 days", 2,"Last 10 Days",getLast10DaysSessions(widget.sessions).length.toString())
                    ],
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(info),
                      Text("$focuss Focus Sessions/0m"),
                     
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      day("sun"),
                      day("mon"),
                      day("tue"),
                      day("wed"),
                      day("thu"),
                      day("fri"),
                      day("sat"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return  Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     pillButton("This month",0),
    //      pillButton("This week",1),
    //       pillButton("Last 10 days",2)
    //   ],
    // );
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

  pillButton(title, buttonId,String inf,String foc) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
                buttonId == bId ? Color.fromARGB(255, 56, 56, 56) : null),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        onPressed: () {
          setState(() {
            bId = buttonId;
            info = inf;
            focuss = foc;
          });
        },
        child: Text(title,
            style: const TextStyle(
              color: Colors.white,
            )));
  }


    List<Session> getCurrentMonthSessions(List<Session> sessions) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int currentMonth = now.month;

    return sessions.where((session) {
      if (session.dateTime.isEmpty) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }

      try {
        DateTime sessionDate = DateTime.parse(session.dateTime);
        return sessionDate.year == currentYear && sessionDate.month == currentMonth;
      } catch (e) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }
    }).toList();
  }

  List<Session> getCurrentWeekSessions(List<Session> sessions) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - currentWeekday));

    return sessions.where((session) {
      if (session.dateTime.isEmpty) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }

      try {
        DateTime sessionDate = DateTime.parse(session.dateTime);
        return sessionDate.isAfter(startOfWeek) && sessionDate.isBefore(endOfWeek);
      } catch (e) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }
    }).toList();
  }

  List<Session> getLast10DaysSessions(List<Session> sessions) {
    DateTime now = DateTime.now();
    DateTime tenDaysAgo = now.subtract(Duration(days: 10));

    return sessions.where((session) {
      if (session.dateTime.isEmpty) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }

      try {
        DateTime sessionDate = DateTime.parse(session.dateTime);
        return sessionDate.isAfter(tenDaysAgo) && sessionDate.isBefore(now);
      } catch (e) {
        print("Invalid date format for session with ID ${session.id}: ${session.dateTime}");
        return false;
      }
    }).toList();
  }
}
