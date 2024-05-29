import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studypal/memory/user_prefrences/user_info.dart';
import 'package:studypal/screens/screen_wrapper.dart';
import 'package:studypal/util/navigator_animator.dart';

final verifyProvider = StateProvider<bool?>((ref) => null,);
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final watchVerification = ref.watch(verifyProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Study Pal",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 35,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Your info to secure your data",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    cursorOpacityAnimates: true,
                    controller: userNameController,
                    onSubmitted: (value) {},
                    decoration: const InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Username",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    cursorOpacityAnimates: true,
                    obscureText: true,
                    controller: userPasswordController,
                    onSubmitted: (value) {},
                    decoration: const InputDecoration(
                      isDense: true,
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  watchVerification!=null&&watchVerification==false?const Text("Invalid credentials, try again",style: TextStyle(color: Colors.red),):Container(),
                   const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async{

                            UserInfo u = UserInfo(userName: userNameController.text, userPassword: userPasswordController.text);
                            if(u.getFirstTimeUse()!=null||u.getFirstTimeUse()==0){
                              print(u.getFirstTimeUse());
                                 u.saveUserName();
                                 u.saveUserPassword();
                                 u.setFirstTimeUse();
                                 navigate();
                            }else{
                            bool verify = await u.verifyPassword();
                            
                            if(verify){
                              
                              ref.read(userNameProvider.notifier).update((state) => userNameController.text,);
                              navigate();
                               
                            }else{
                              ref.read(verifyProvider.notifier).update((state) => false,);
                            }
                            }
                        
                           
                          }, child: const Text("Login")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  navigate(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) =>const ScreenWrapper(),));
  }
}
