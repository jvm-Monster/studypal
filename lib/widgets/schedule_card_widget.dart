import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScheduleCardWidget extends StatelessWidget {
  final String task;
  final DateTime dateTime;
  const ScheduleCardWidget({super.key,required this.task,required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return  const Card(
      color: Colors.blueAccent,
      child:Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mathematical Method",style: TextStyle(
                color: Colors.white
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10:20 - 10:30",style: TextStyle(
                    color: Colors.white
                ),),
                SizedBox(width: 5,),
                Icon(CupertinoIcons.arrow_right_circle_fill,color: Colors.white,)
              ],
            )
          ],
        ),
      ),
    );
  }


}
