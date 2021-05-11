import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/common/chat/chat.dart';
import 'package:health_bag/pages/common/latestTestResults.dart';
import 'package:health_bag/pages/patients/patientMedications/currentMedications.dart';
import 'package:health_bag/pages/patients/patientNotifications.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class PatientHome extends StatefulWidget {
  static String id = 'patient-home';

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

Future<DocumentSnapshot> getPatientData(String patientUID) async {
  return await FirebaseFirestore.instance
      .collection('Patients')
      .doc(patientUID)
      .get();
}

Future<DocumentSnapshot> getDoctorData(String doctorUID) async {
  return await FirebaseFirestore.instance
      .collection('Doctors')
      .doc(doctorUID)
      .get();
}

class _PatientHomeState extends State<PatientHome> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "No data";

  @override
  void initState() {
    super.initState();
    String patientUID = FirebaseAuth.instance.currentUser.uid;
    getPatientData(patientUID).then((patientData) {
      getDoctorData(patientData.data()['DoctorUID']).then((doctorData) => {
            getSharedText(doctorData.data()['Name'], patientUID,
                patientData.data()['DoctorUID'], doctorData.data()['Photo']),
          });
    });
  }

  getSharedText(String doctorName, String patientUID, String doctorUID,
      String doctorPhoto) async {
    var sharedData = await platform.invokeMethod("getSharedText");
    if (sharedData != null) {
      setState(() {
        dataShared = sharedData;
      });
    }
    if (dataShared != "No data") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Chat(
            peerName: doctorName,
            id: patientUID,
            peerId: doctorUID,
            peerAvatar: doctorPhoto,
            sharedMessage: dataShared,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      String uid = loginStore.firebaseUser.uid;
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              FourthBackground(),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 20,
                  right: 20,
                ),
                child: MyFonts().title1('Home', MyColors.white),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Assigned Doctor')
                          .doc(uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        else {
                          String doctorUID =
                              (snapshot.data.data()['DoctorUID']);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyFonts()
                                  .heading1('Doctor Details', MyColors.black),
                              MySpaces.vGapInBetween,
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Doctors')
                                      .doc(doctorUID)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Center(
                                          child: CircularProgressIndicator());
                                    else {
                                      var doctorInfo = snapshot.data.data();
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    doctorInfo['Photo']),
                                                radius: 50,
                                              ),
                                              MySpaces.hLargeGapInBetween,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    MyFonts().heading2(
                                                        doctorInfo['Name'],
                                                        MyColors.blueLighter),
                                                    MyFonts().body(
                                                        doctorInfo[
                                                            'Specialisation'],
                                                        MyColors.blueLighter),
                                                    MyFonts().subHeadline(
                                                        '${doctorInfo['HospitalName']}, ${doctorInfo['DepartmentName']} Department',
                                                        MyColors.blueLighter),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          MySpaces.vSmallGapInBetween,
                                          Row(
                                            children: [
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'Patient Chat Bubbles')
                                                      .doc(uid)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData)
                                                      return Container();
                                                    else {
                                                      bool isUnread = snapshot
                                                          .data
                                                          .data()['bubble'];
                                                      return Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          // ignore: deprecated_member_use
                                                          RaisedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          Chat(
                                                                            peerName:
                                                                                doctorInfo['Name'],
                                                                            id: uid,
                                                                            peerId:
                                                                                doctorUID,
                                                                            peerAvatar:
                                                                                doctorInfo['Photo'],
                                                                            sharedMessage:
                                                                                null,
                                                                          )));
                                                            },
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .paperplane_fill,
                                                                  color: MyColors
                                                                      .white,
                                                                ),
                                                                MySpaces
                                                                    .hGapInBetween,
                                                                MyFonts().heading2(
                                                                    'Chat',
                                                                    MyColors
                                                                        .white),
                                                              ],
                                                            ),
                                                            color: MyColors
                                                                .blueLighter,
                                                          ),
                                                          Visibility(
                                                            visible: isUnread,
                                                            child: Positioned(
                                                              top: -5,
                                                              right: -5,
                                                              child: Icon(
                                                                Icons
                                                                    .brightness_1,
                                                                color: MyColors
                                                                    .redLighter,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  }),
                                              Spacer(),
                                              StreamBuilder(
                                                  stream: FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'Notification Bubbles')
                                                      .doc(uid)
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData)
                                                      return Container();
                                                    else {
                                                      bool isUnread = snapshot
                                                          .data
                                                          .data()['bubble'];
                                                      return Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          // ignore: deprecated_member_use
                                                          RaisedButton(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  PatientNotifications
                                                                      .id);
                                                            },
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .bell_solid,
                                                                  color: MyColors
                                                                      .white,
                                                                ),
                                                                MySpaces
                                                                    .hGapInBetween,
                                                                MyFonts().heading2(
                                                                    'Show Notification',
                                                                    MyColors
                                                                        .white),
                                                              ],
                                                            ),
                                                            color: MyColors
                                                                .redLighter,
                                                          ),
                                                          Visibility(
                                                            visible: isUnread,
                                                            child: Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              child: Icon(
                                                                Icons
                                                                    .brightness_1,
                                                                color: MyColors
                                                                    .white,
                                                                size: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  }),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                              MySpaces.vSmallGapInBetween,
                              MyFonts()
                                  .heading1('Doctor Notes', MyColors.black),
                              MySpaces.vGapInBetween,
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Doctor Notes')
                                      .doc(uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Container();
                                    else {
                                      var notes = snapshot.data.data()['Note'];
                                      return (notes.length == 0)
                                          ? MyFonts().body(
                                              'Sorry you doctor has not added any notes at the moment.',
                                              MyColors.gray)
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (int i = 0;
                                                    i < notes.length;
                                                    i++)
                                                  MyFonts().body(
                                                      '• ${notes[i]}',
                                                      MyColors.blueLighter)
                                              ],
                                            );
                                    }
                                  }),
                              MySpaces.vSmallGapInBetween,
                              MyFonts()
                                  .heading1('Important Dates', MyColors.black),
                              MySpaces.vGapInBetween,
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Important Dates')
                                      .doc(uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData)
                                      return Container();
                                    else {
                                      var dates = snapshot.data.data();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              MyFonts().heading2(
                                                  '• Last Visit: ',
                                                  MyColors.blueLighter),
                                              (dates['LastVisit'] == '')
                                                  ? MyFonts().body(
                                                      'Not available',
                                                      MyColors.gray)
                                                  : MyFonts().heading2(
                                                      dates['LastVisit'],
                                                      MyColors.redLighter)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              MyFonts().heading2(
                                                  '• Next Visit: ',
                                                  MyColors.blueLighter),
                                              (dates['NextVisit'] == '')
                                                  ? MyFonts().body(
                                                      'Not available',
                                                      MyColors.gray)
                                                  : MyFonts().heading2(
                                                      dates['NextVisit'],
                                                      MyColors.redLighter)
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                              MySpaces.vSmallGapInBetween,
                              CurrentMedications(patientUID: uid),
                              MySpaces.vSmallGapInBetween,
                              LatestTestResults(patientUID: uid),
                              MySpaces.vSmallGapInBetween,
                            ],
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
