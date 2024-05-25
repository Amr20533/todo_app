import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationApi{
static final _notification = FlutterLocalNotificationsPlugin();
// static Future notificationDetails() async {
// return NotificationDetails(
//   android: AndroidNotificationDetails(
//     'Channel id',
//     'Channel name',
//     importance: Importance.max,priority: Priority.max
//
//   ),
//
//   // iOS: IOSNotificationDetails(),
// );
// }
static Future init({bool initScheduled = false})async{
  DarwinInitializationSettings ios = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    requestCriticalPermission: true,
  );

  final android = AndroidInitializationSettings('@mipmap/ic_launcher');
  InitializationSettings settings = InitializationSettings(android: android,
  iOS: ios
  );

  bool? initialized = await _notification.initialize(settings,
      onDidReceiveNotificationResponse:(payload) async{}, );
  print('Notification: $initialized');

}
// static Future showNotification({
//   int id = 0,
//   String? title,
//   String? body,
//   String? payload,
//
// }) async => _notification.show(id, title, body,await notificationDetails(),payload: payload);

static void showNotification()async{
  DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );
  AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'youtube_id',
      'youtube',
      importance: Importance.max,
      priority: Priority.max
  );
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
    iOS:iosDetails
  );
  await _notification.show(0, 'local notification', "this is an notification", notificationDetails);

}
}