import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TripNotification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  TripNotification(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings iOSInitializationSettings =
        IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<String?> selectNotification(String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Notification Clicked"),
              content: Text("You clicked the notification."),
            ));
  }

  Future showNotification() async {
    // ignore: prefer_const_constructors
    var android = AndroidNotificationDetails("channelId", "channelName",
        priority: Priority.high, importance: Importance.max);
    var platformDetails = NotificationDetails(android: android);
    await notification.show(100, "Simple Notification",
        "This is a simple notification", platformDetails,
        payload: "a demo payload");
  }
}
