import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/functions/general/getDayFromWeek.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/doctor/patientmonitor/patientmedications/medicineGlobals.dart'
    as globals;
import 'package:health_bag/pages/patients/patientMedications/viewMedicine.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CurrentMedications extends StatefulWidget {
  static String id = 'current-medications';
  final String patientUID;

  CurrentMedications({@required this.patientUID});

  @override
  _CurrentMedicationsState createState() =>
      _CurrentMedicationsState(patientUID: patientUID);
}

class _CurrentMedicationsState extends State<CurrentMedications> {
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
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future _showNotifications(List<Map> medicineNotification) async {
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails('nch', 'Medicine Notification Channel',
            'Receive medicine notifications',
            icon: 'app_icon',
            importance: Importance.max,
            priority: Priority.high,
            largeIcon: DrawableResourceAndroidBitmap('pills_icon'),
            styleInformation: BigTextStyleInformation(''));
    NotificationDetails notificationDetails =
        new NotificationDetails(android: androidNotificationDetails);
    for (int i = 0; i < medicineNotification.length; i++) {
      print(medicineNotification[i]['Time']);
      if (medicineNotification[i]['Time'].isAfter(tz.TZDateTime.now(tz.local)))
        await flutterLocalNotificationsPlugin.zonedSchedule(
          new Random().nextInt(100000),
          MyStrings().currentMedicationsTimeForMeds,
          "Name: ${medicineNotification[i]['Name']}\nDosage: ${medicineNotification[i]['Dosage']}\nNotes: ${medicineNotification[i]['Notes']}",
          medicineNotification[i]['Time'],
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true,
        );
    }
  }

  void scheduleMedicine(Map medicineData) {
    String endDateStr = medicineData['End Date'];
    endDateStr = endDateStr.split('-').reversed.join('-') + " 00:00:00.000";
    tz.TZDateTime endDate =
        (tz.TZDateTime.parse(tz.local, endDateStr)).add(Duration(days: 1));
    tz.TZDateTime currentDate = tz.TZDateTime.now(tz.local);

    List<Map> medicineNotification = [];

    while (!currentDate.isAfter(endDate)) {
      int day = currentDate.weekday - 1;
      String weekDayName = getWeekFromDay(day);
      for (int i = 0; i < medicineData[weekDayName].length; i++) {
        tz.TZDateTime notificationTime = (tz.TZDateTime.parse(
            tz.local,
            currentDate.toString().split(' ')[0] +
                ' ' +
                format12To24HrTime(medicineData[weekDayName][i]['Time'])));
        medicineNotification.add({
          'Name': medicineData['Name'],
          'Dosage': medicineData[weekDayName][i]['Dosage'],
          'Notes': medicineData[weekDayName][i]['Notes'],
          'Time': notificationTime,
        });
      }
      currentDate = currentDate.add(Duration(days: 1));
    }
    _showNotifications(medicineNotification);
  }

  final String patientUID;

  _CurrentMedicationsState({@required this.patientUID});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  Icon schedule = Icon(
    CupertinoIcons.alarm_fill,
    color: MyColors.white,
  );
  Icon done = Icon(
    CupertinoIcons.checkmark_seal_fill,
    color: MyColors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MySpaces.vGapInBetween,
        MyFonts().heading1(MyStrings().currentMedicationsHeading, MyColors.black),
        MySpaces.vGapInBetween,
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Medicines').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container();
              else {
                List<Map> medicineData = [];
                List<String> medicineID = [];
                List<bool> medicineScheduled = [];
                List<Icon> icon = [];

                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  if (snapshot.data.docs[i].data()['PatientUID'] ==
                      patientUID) {
                    medicineData.add(snapshot.data.docs[i].data());
                    medicineID.add(snapshot.data.docs[i].id);
                    medicineScheduled
                        .add(snapshot.data.docs[i].data()['medicineScheduled']);
                    if (medicineScheduled.last == false)
                      icon.add(schedule);
                    else
                      icon.add(done);
                  }
                }
                return (medicineData.length == 0)
                    ? MyFonts().body(
                    MyStrings().currentMedicationsNoMedicines,
                        MyColors.gray)
                    : Column(
                        children: [
                          for (int i = 0; i < medicineData.length; i++)
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    globals.timingsAndNotesArray[0] =
                                        List.from(medicineData[i]['Monday']);
                                    globals.timingsAndNotesArray[1] =
                                        List.from(medicineData[i]['Tuesday']);
                                    globals.timingsAndNotesArray[2] =
                                        List.from(medicineData[i]['Wednesday']);
                                    globals.timingsAndNotesArray[3] =
                                        List.from(medicineData[i]['Thursday']);
                                    globals.timingsAndNotesArray[4] =
                                        List.from(medicineData[i]['Friday']);
                                    globals.timingsAndNotesArray[5] =
                                        List.from(medicineData[i]['Saturday']);
                                    globals.timingsAndNotesArray[6] =
                                        List.from(medicineData[i]['Sunday']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ViewMedicine(
                                                  medicineData: medicineData[i],
                                                  medicineID: medicineID[i],
                                                )));
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    tileColor: MyColors.white,
                                    leading: Image(
                                        image: AssetImage(
                                            'assets/icons/pills.png')),
                                    title: MyFonts().heading2(
                                        medicineData[i]['Name'],
                                        MyColors.black),
                                    subtitle: MyFonts().body(
                                        'Ends On: ${medicineData[i]['End Date']}',
                                        MyColors.gray),
                                    trailing: Container(
                                      decoration: BoxDecoration(
                                          color: icon[i] == schedule
                                              ? MyColors.redLighter
                                              : Colors.greenAccent,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        onPressed: () {
                                          if (icon[i] == schedule) {
                                            setState(() {
                                              FirebaseFirestore
                                                  firestoreInstance =
                                                  FirebaseFirestore.instance;
                                              firestoreInstance
                                                  .collection('Medicines')
                                                  .doc(medicineID[i])
                                                  .update({
                                                'medicineScheduled': true
                                              });
                                            });
                                            final scheduleMedicineSnackBar =
                                                SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        MyColors.black,
                                                    content: MyFonts().body(
                                                        "${medicineData[i]['Name']} has been scheduled",
                                                        MyColors.white));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    scheduleMedicineSnackBar);
                                            scheduleMedicine(medicineData[i]);
                                          }
                                        },
                                        icon: icon[i],
                                      ),
                                    ),
                                  ),
                                ),
                                MySpaces.vGapInBetween,
                              ],
                            ),
                        ],
                      );
              }
            }),
      ]),
    );
  }
}
