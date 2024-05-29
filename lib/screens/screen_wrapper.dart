import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'package:studypal/memory/database/session_database_helper.dart';
import 'package:studypal/memory/user_prefrences/user_info.dart';
import 'package:studypal/memory/user_prefrences/user_theme_preferences.dart';
import 'package:studypal/screens/activity_screen.dart';
import 'package:studypal/screens/session_screen.dart';
import 'package:studypal/screens/setting_screen.dart';
import 'home_screen.dart';

final streamDurationFinishedProvider = StateProvider((ref) => false,);
final currentIndexProvider = StateProvider((ref) => 0,);
final userNameProvider = StateProvider((ref) => "",);
class ScreenWrapper extends ConsumerStatefulWidget {
  const ScreenWrapper({super.key});

  @override
  createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends ConsumerState<ScreenWrapper> {
   final GlobalKey<ScaffoldState> _key = GlobalKey();
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  TextEditingController userNameController = TextEditingController();
   TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final watchUserNameProvider = ref.watch(userNameProvider);
    final watchSession = ref.watch(sessionProvider);
    final watchStreamDurationFinishedProvider = ref.watch(streamDurationFinishedProvider);
    final watchCurrentIndexProvider = ref.watch(currentIndexProvider);
    return Scaffold(
      key: _key,
     
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        pageSnapping: false,
        children: const [
          HomeScreen(),
          SessionScreen(),
          ActivityScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != 1&&watchSession!=null&&watchStreamDurationFinishedProvider==false) {

            // If the user navigates away from the SessionScreen
            // show the confirmation dialog
              showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(

                   title: const Text('Cancel Session?'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  "assets/images/sure_illu.jpg",height: 200,
                  ),
              ),
              const SizedBox(height: 10,),
              const Expanded(
                child: Text(
                  'You have made significant progress. Cancelling now means you won’t complete your task. Are you sure you want to cancel the session?',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No, Continue'),
            ),
            TextButton(
              onPressed: () {
                 ref.read(createASessionProvider.notifier).update((state) => false,);
                // watchSession.setIsCanceled(1);
                // SessionDatabaseHelper.createNewSession(watchSession);
                   currentIndex = index;
                          _pageController.animateToPage(
                            currentIndex,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          ref.watch(sessionProvider.notifier).update((state) => null,);
                    Navigator.of(context).pop();
              },
              child: const Text('Yes, Cancel'),
            ),
          ],
                );
              },
            );
          } else {
               
            
            currentIndex = index;
              _pageController.animateToPage(
                currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              ref.read(currentIndexProvider.notifier).update((state)=> currentIndex );
              ref.read(streamDurationFinishedProvider.notifier).update((state) => false,); 
          }
        },
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: "Sessions"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Activities"),
        ],
      ),
    //   drawer: Drawer(
      
    //   child: ListView(
    //     // Important: Remove any padding from the ListView.
    //     padding: EdgeInsets.zero,
    //     children: [
    //        DrawerHeader(
    //         decoration: const BoxDecoration(
    //           color: Colors.blueAccent,
    //         ),
    //         child: Text(watchUserNameProvider,style: const TextStyle(fontSize:25),)
    //       ),
    //       ListTile(
    //         leading: const Icon(
    //           Icons.person_2,
    //         ),
    //         title: const Text('Change username'),
    //         onTap: () {
    //            showDialog(context: context, builder: (context) {
    //              return AlertDialog(
    //                 title: const Text("Change Username",style: TextStyle(fontSize: 20),),
    //                 content:   TextField(
    //                 cursorOpacityAnimates: true,
    //                 controller: userNameController,
    //                 onSubmitted: (value) {},
    //                 decoration: const InputDecoration(
    //                   isDense: true,
    //                   labelStyle: TextStyle(color: Colors.grey),
    //                   labelText: "Username",
    //                   floatingLabelBehavior: FloatingLabelBehavior.never,
    //                   border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(20))),
    //                 ),
    //               ),
    //               actions: [

    //                  TextButton(onPressed: (){
    //                     Navigator.pop(context);
    //                  }, child: const Text("Cancel")),

    //                  TextButton(onPressed: (){
    //                    UserInfo.updateUserName(userNameController.text, ref);
    //                    Navigator.pop(context);
    //                  }, child: const Text("Ok")),

                      
    //               ],
    //              );
    //            },);
    //         },
    //       ),
    //       ListTile(
    //         leading: const Icon(
    //           Icons.password,
    //         ),
    //         title: const Text('Change password'),
    //         onTap: () {
    //            showDialog(context: context, builder: (context) {
    //              return AlertDialog(
    //                 title: const Text("Change Password",style: TextStyle(fontSize: 20),),
    //                 content:   TextField(
    //                   obscureText: true,
    //                 cursorOpacityAnimates: true,
    //                 controller: userPasswordController,
    //                 onSubmitted: (value) {},
    //                 decoration: const InputDecoration(
    //                   isDense: true,
    //                   labelStyle: TextStyle(color: Colors.grey),
    //                   labelText: "Passowrd",
    //                   floatingLabelBehavior: FloatingLabelBehavior.never,
    //                   border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.all(Radius.circular(20))),
    //                 ),
    //               ),
    //               actions: [

    //                  TextButton(onPressed: (){
    //                     Navigator.pop(context);
    //                  }, child: const Text("Cancel")),
                     
    //                  TextButton(onPressed: (){
    //                    UserInfo.updatePassword(watchUserNameProvider, userPasswordController.text);
    //                        Navigator.pop(context);
    //                  }, child: const Text("Ok")),

                      
    //               ],
    //              );
    //            },);
    //         },
    //       ),
    //     ],
    //   ),
    // ),
    );
  }
}

 