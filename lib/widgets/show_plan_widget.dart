import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowPlanWidget extends ConsumerStatefulWidget {
  const ShowPlanWidget({super.key});

  @override
  ConsumerState createState() => _ShowPlanWidgetState();
}

class _ShowPlanWidgetState extends ConsumerState<ShowPlanWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("My Study Plan",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff0088FF).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10)
              ),
      
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    days("M"),
                    days("T"),
                    days("W"),
                    days("TH"),
                    days("F"),
                    days("S"),
                    days("S")
                  ],),
              ),
            ),
      
            const SizedBox(height: 20,),
      
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Monday", style: TextStyle(fontWeight: FontWeight.bold,fontSize:20)),
                    const SizedBox(height: 10,),
                    taskWidget(Colors.red, "Go To The Market Tomorrow","11:05 - 11:40" ),
                    taskWidget(Colors.blue, "Eat My Food", "10:20 - 10:30"),
                    taskWidget(Colors.purpleAccent, "Drink Water", "11:05 - 11:40"),
                    taskWidget(Colors.green, "Go To The Market Tomorrow","11:05 - 11:40" ),
                    taskWidget(Colors.yellow, "Go To The Market Tomorrow","11:05 - 11:40" )
      
                  ],
                ),
              ),
            )
      
          ],
        ),
      ),
    );
  }

  Widget days(String text){
    return GestureDetector(
      onTap: () {
        print(text);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,style: const TextStyle(color: Color(0xff0088FF),fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  Widget taskWidget(Color color,String task, String time){
    return   Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 5,
              height: 45,

              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task, style: TextStyle(fontSize: 15)),
                Text(time, style: TextStyle(color: Colors.grey)),
              ],
            )

          ],
        ),
        const SizedBox(height: 15,)
      ],
    );

  }
}
