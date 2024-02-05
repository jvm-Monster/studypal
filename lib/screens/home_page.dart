import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studypal/screens/tasks_screen.dart';
import 'package:studypal/widgets/app_bar_widget.dart';

import '../widgets/card_info_widget.dart';
import '../widgets/quote_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const AppBarWidget(appBarTitile: "Home"),
        Padding(
              padding:  const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        CardInfoWidget(title: "Today", icon:  const Icon(CupertinoIcons.star_fill,color: Colors.yellow,),doThis:(){}),


                        CardInfoWidget(title: "Completed", icon: const Icon(CupertinoIcons.check_mark_circled_solid,color: Colors.grey,),doThis: () {},)

                      ],
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardInfoWidget(title: "View Plan", icon: const Icon(CupertinoIcons.plus_app,color: Colors.purpleAccent,),
                          doThis: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TasksScreen(),));
                          },)
                      ],
                    ),

                    const SizedBox(height: 20,),

                    const Row(
                      children: [
                        Text("Schedule",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                      ],

                    ),
                    const Card(
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
                    ),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        Text("Be Motivated",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),

                    const QuoteWidget(),
                    const SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
      ],
    );
  }
}
