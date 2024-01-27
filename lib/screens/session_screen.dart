import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:studypal/widgets/app_bar_widget.dart';
import 'package:studypal/widgets/time_input_widget.dart';
import 'package:timer_count_down/timer_count_down.dart';


class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  bool counterPaused = false;
  bool increasingTimer = false;
  bool changeTimer = false;
  late final StreamDuration streamDuration;

  @override
  void initState() {
    super.initState();
    streamDuration = StreamDuration(
      config: const StreamDurationConfig(
        countDownConfig: CountDownConfig(
          duration: Duration(hours:0,minutes:0,seconds: 0),
        ),
      ),
    );
  }
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppBarWidget(
            appBarTitile: "Session",
        ),

        Column(
          children: [

            GestureDetector(
              onVerticalDragDown: (details) {
                streamDuration.add(Duration(seconds: 1));
              },
              onVerticalDragStart: (details) {
                print('print drag up');
                print(details);
                setState(() {
                  value = value++;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF0088FF)
                        .withOpacity(0.4), // Set your desired border color
                    width: 10.0, // Set the width of the border
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Colors.transparent,
                  maxRadius: 140, // Make the CircleAvatar transparent
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SlideCountdown(
                       slideDirection: SlideDirection.none,

                        showZeroValue: true,
                        // This duration no effect if you customize stream duration
                        streamDuration: streamDuration,
                        decoration: const BoxDecoration(
                            color: Colors.transparent
                        ),
                        style: const TextStyle(
                          color: Color(0xFF0088FF),
                          fontSize: 40
                        ),
                        separator: ":",
                        separatorStyle: const TextStyle(fontSize: 40),
                      ),

                      const Text("Next Up:Focus")
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      /*  Countdown(
          seconds: 1000,
          build: (BuildContext context, double time) => Text(time.toString()),
          interval: Duration(milliseconds: 100),
          onFinished: () {
            print('Timer is done!');
          },
        )*/

       /* const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 30,
              child: TextField(),
            ),
            SizedBox(
              width: 30,
              child: TextField(),
            ),
            SizedBox(
              width: 30,
              child: TextField(),
            ),
          ],
        ),*/



      /*  ElevatedButton(onPressed: (){
          streamDuration.pause();
          showD();
        }, child: Text("Change timer")),
*/

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {

                  streamDuration.subtract(Duration(seconds: 1));
                },
                icon: Icon(
                  CupertinoIcons.minus_circle_fill,
                  size: 45,
                  color: Color(0xFF9E9E9E),
                )),
            IconButton(
                onPressed: () {
                  setState(() {

                    if(counterPaused){
                      setState(() {
                        counterPaused=false;
                        streamDuration.play();
                      });

                    }else{
                      counterPaused=true;
                      streamDuration.pause();

                    }

                  });
                },
                icon: Icon(
                  CupertinoIcons.play_circle_fill,
                  size: 50,
                  color: Color(0xFF9E9E9E),
                )),
            IconButton(
                onPressed: () {
                  increasingTimer=true;
                  if(increasingTimer==true){
                    streamDuration.pause();
                    streamDuration.add(Duration(seconds: 1));
                    increasingTimer=false;
                    streamDuration.resume();
                  }


                },
                icon: Icon(
                  CupertinoIcons.add_circled_solid,
                  size: 45,
                  color: Color(0xFF9E9E9E),
                )),
          ],
        )


      ],
    );
  }
  showD(){
    showDialog(context: context, builder: (context) {

      return TimePickerDialog(
        onEntryModeChanged: (p0) =>TimePickerEntryMode.dialOnly,
          initialTime: TimeOfDay(hour: 0, minute: 0)
      );
    },);
  }
  @override
  void dispose() {
    super.dispose();
    streamDuration.dispose();
  }
}
