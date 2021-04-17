import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TestNotifications extends StatefulWidget {
  static String id = 'test-notifications-local';

  @override
  createState() => _TestNotificationsState();
}

class _TestNotificationsState extends State<TestNotifications> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    AndroidInitializationSettings initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings =
        new InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onNotificationPressed);
  }

  Future _showNotifications() async {
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
            'nch', 'Notification Channel', 'Receive a test notification');
    NotificationDetails notificationDetails =
        new NotificationDetails(android: androidNotificationDetails);
    // await flutterLocalNotificationsPlugin.show(0, 'Notification Title',
    //     'This is a test notification', notificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        new Random().nextInt(100000),
        'First Notification Title',
        'This is first test notification',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        new Random().nextInt(100000),
        'Second Notification Title',
        'This is second test notification',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          padding: EdgeInsets.all(20),
          onPressed: _showNotifications,
          color: MyColors.blue,
          child: MyFonts().body('Press me', MyColors.white),
        ),
      ),
    );
  }

  Future onNotificationPressed(String payload) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: MyFonts()
                  .body('Here is your notification babe!', MyColors.black),
            ));
  }
}
