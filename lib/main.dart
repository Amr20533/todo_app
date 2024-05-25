import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:todo_app/layout/task_screen.dart';
import 'package:todo_app/models/student_model.dart';
import 'package:todo_app/modules/notify/notification_api.dart';
import 'package:todo_app/services/demo_purchase.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await ShoppingDB.initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:(context)=> screen),(route) =>false)

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>TodoCubit()..createDatabase(),
    child: BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Todo App',
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode:TodoCubit.get(context).dark?ThemeMode.dark:ThemeMode.light,
          home: TaskScreen(),
        );
      },
    ),);
  }
}
///fcm
//https://www.youtube.com/watch?v=E3HsF_6_Mb8&list=PL93xoMrxRJIve-GSKU61X6okh5pncG0sH&index=39
/// alarm clock app
/// https://www.geeksforgeeks.org/flutter-building-an-alarm-clock-app/
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height:120),
              MaterialButton(onPressed: () =>
                  NotificationApi.showNotification(),
                color: Colors.blue,
                elevation: 0.0,
                child: Text('local notification',style: TextStyle(color:Colors.white,fontSize: 18),),
              ),
              const SizedBox(height:15.0),
              MaterialButton(onPressed: (){},
                color: Colors.blue,
                elevation: 0.0,
                child: Text('sceduled notification',style: TextStyle(color:Colors.white,fontSize: 18),),
              ),
              const SizedBox(height:15.0),
              MaterialButton(onPressed: (){},
                color: Colors.blue,
                elevation: 0.0,
                child: Text('delete notification',style: TextStyle(color:Colors.white,fontSize: 18),),
              ),
              const SizedBox(height:15.0),
            ],
          ),
        ),
      ),
    );
  }
}
/*
 theme:ThemeData(
      primaryColor:Color(0xFF0D8E63),
      scaffoldBackgroundColor:Color(0xFFFeFCFC),
      textTheme:Theme.of(context).textTheme.apply(displayColor:Color(0xFF1E2432))
    ), */
class TTSScreen extends StatelessWidget {
  TTSScreen({Key? key}) : super(key: key);
  final FlutterTts flutterTts = FlutterTts();
  var textController = TextEditingController();
  speak(String text) async{
    await flutterTts.setLanguage('en-US');
    // await flutterTts.setSpeechRate(1.0);

    // await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0); // 0.5 to 1.5
    // await flutterTts.synthesizeToFile("Hello World", Platform.isAndroid ? "tts.wav" : "tts.caf");
    await flutterTts.isLanguageAvailable("en-US");

    await flutterTts.speak(text);

    // iOS only
    await flutterTts.setSharedInstance(true);

// Android only
    await flutterTts.setSilence(1);

    // await flutterTts.getEngines;

    // await flutterTts.getDefaultVoice;

    await flutterTts.isLanguageInstalled("en-US");

    await flutterTts.areLanguagesInstalled(["en-US", "en-US"]);

    // await flutterTts.setQueueMode(1);

    // await flutterTts.getMaxSpeechInputLength;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:KBackground(
        child:  SingleChildScrollView(
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const SizedBox(height:20.0),
                  SvgPicture.asset('assets/images/login.svg',width:MediaQuery.of(context).size.width * 0.6),
                  const SizedBox(height:20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextFormField(
                      controller:textController,
                      decoration: InputDecoration(
                        hintText: 'Type in something...',
                        enabledBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:const BorderSide(color: Colors.deepPurple),
                          borderRadius:BorderRadius.circular(12.0),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: Icon(Icons.title,color: Colors.purple.withOpacity(0.6),),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height:15.0),
                  // GestureDetector(
                  //   onTap: ()async => await speak(textController.text),
                  //   child: Container(alignment: Alignment.center,
                  //     width: 200,height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child:const Text('Speak',style: TextStyle(color: Colors.white,fontSize: 22),),
                  //   ),
                  // )
                  // TextButton(
                  //   onPressed: () async => await speak(textController.text),
                  //     style: ButtonStyle(
                  //       backgroundColor:MaterialStateProperty.all(Colors.blueAccent),
                  //         overlayColor: MaterialStateProperty.all(Colors.transparent)
                  //     ),
                  //   child:const Text('Speak',style: TextStyle(color: Colors.white,fontSize: 22),),
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.deepPurple.withOpacity(0.8),
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(150,40),
                    ),
                    onPressed: () => speak(textController.text),
                    child:const Text('Speak',style: TextStyle(color: Colors.white,fontSize: 22),),
                  ),
                ]
            ),
          ),
        ),
      )
    );
  }
}
class KBackground extends StatelessWidget {
  final Widget child;
  KBackground({required this.child});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      color:Colors.white,
      width:double.infinity,
      height:size.height,
      child:Stack(
        alignment:AlignmentDirectional.center,
        children: [
          Positioned(top:0,left:0,
            child:Image.asset('assets/images/main_top.png',width:size.width * 0.32 ),),
          Positioned(bottom:0,right:0,
            child:Image.asset('assets/images/login_bottom.png',width:size.width * 0.32 ),),
          child,
        ],),
    );
  }
}

