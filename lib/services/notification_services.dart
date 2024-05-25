import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/payload_screen.dart';
class NotificationHelper{
  static FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); // initialize instance for flutter notification plugins

  //first called function that we will use in our app to get our notification
  initializeNotification() async {
    _configureLocalTimeZone();
    //tz.initializeTimeZones();
    //IOSInitializationSettings can be replaced with DarwinInitializationSettings
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
       // onDidReceiveLocalNotification: onDidReceiveLocalNotification //required for older ios devices
    );
    // bool? initialized = await flutterLocalNotificationsPlugin.initialize(settings,
    //   onDidReceiveNotificationResponse:(payload) async{}, );

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("ic_launcher");

    const InitializationSettings initializationSettings =
    InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification
      //onDidReceiveNotificationResponse: invoked only when the app is running.
      // This works for when a user has selected a notification or notification action.
      // This replaces the onSelectNotification callback that existed before.
    );
  }


  static Future<void> displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id'  //'your channel id'
        'your channel name',//'your channel name'
        'your channel description',//'your channel description'
        importance: Importance.max, priority: Priority.high);
    //iOS and macOS classes have been renamed and refactored as they are based on the same operating system
    // and share the same notification APIs. Rather than having a prefix of either IOS or MacOS,
    // these are now replaced by classes with a Darwin prefix. For example, IOSInitializationSettings can be replaced with DarwinInitializationSettings
    //var iOSPlatformChannelSpecifics = const DarwinInitializationSettings();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics.defaultPresentSound
    );
    await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: title
      // payload: 'It could be anything you pass',
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  static scheduledNotification(int hour,int minute,Task task) async {
    // int nTime = minute;
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,      //task!.id.toInt()
        task.title, //task.title 'scheduled title'
        task.note, //task.note 'task note [ channel description ]'
        convertTime(hour,minute,),
        //  tz.TZDateTime.now(tz.local).add(Duration(seconds: nTime)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id'
                    'your channel name',
                'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title} |" " ${task.note}|"
    );

  }


  Future onDidReceiveLocalNotification(BuildContext context,
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      //context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child:const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayloadScreen(payload!),
                ),
              );
            },
          )
        ],
      ), context: context,
    );

   // Get.dialog(const Text("Welcome To flutter"));
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if(payload == "Theme Changed"){
      print("Noting to navigate to");
    }else{
      //Get.to(()=>NotifiedPage(label: payload!,));
      print('go to payload!');
    }
  }
  static tz.TZDateTime convertTime(int hour,int minute){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minute );
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}







/* ios missed files initialization
ios -> runner -> AppDelegate.swift
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
* */
/* android missed files initialization
android -> app -> src -> main -> res -> drawable/app_icon.png
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
* */