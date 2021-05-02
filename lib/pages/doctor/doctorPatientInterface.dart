import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/common/chat/chat.dart';
import 'package:health_bag/pages/doctor/doctorSendNotifications.dart';
import 'package:health_bag/pages/doctor/patientmonitor/monitorPatientHealth.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorPatientInterface extends StatefulWidget {
  static String id = 'doctor-patient-interface';
  final String patientNumber;

  DoctorPatientInterface({@required this.patientNumber});

  @override
  _DoctorPatientInterfaceState createState() =>
      _DoctorPatientInterfaceState(patientNumber: patientNumber);
}

Widget _getRow(String key, String val) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFonts().heading2(key, MyColors.blueLighter),
          MySpaces.hLargeGapInBetween,
          Flexible(child: Text(
            val,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'poppins-semi',
              fontSize: 15,
              color: MyColors.gray,
            ),
          )),
        ],
      ),
      Divider(),
    ],
  );
}

class _DoctorPatientInterfaceState extends State<DoctorPatientInterface> {
  final String patientNumber;

  _DoctorPatientInterfaceState({@required this.patientNumber});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var doctorUid = loginStore.firebaseUser.uid;
      return Scaffold(
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Patients')
                  .where('PhoneNumber', isEqualTo: patientNumber)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else {
                  var userData = snapshot.data.docs[0].data();
                  var patientUID = snapshot.data.docs[0].id;
                  String title = userData['Name'].split(' ')[0];
                  return Stack(
                    children: [
                      FourthBackground(),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                          left: 20,
                          right: 20,
                        ),
                        child: MyFonts()
                            .title1("$title's Profile", MyColors.white),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          left: 20,
                          right: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MySpaces.vSmallGapInBetween,
                              Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData['Photo']),
                                  radius: 60,
                                ),
                              ),
                              MySpaces.vSmallestGapInBetween,
                              Center(
                                  child: MyFonts().heading1(
                                      '${userData['Name']}', MyColors.black)),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Chat(
                                                    peerName: userData['Name'],
                                                    id: doctorUid,
                                                    peerId: patientUID,
                                                    peerAvatar:
                                                        userData['Photo'],
                                                  )));
                                    },
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.paperplane_fill,
                                          color: MyColors.white,
                                        ),
                                        MySpaces.hGapInBetween,
                                        MyFonts()
                                            .heading2('Chat', MyColors.white),
                                      ],
                                    ),
                                    color: MyColors.blueLighter,
                                  ),
                                  Spacer(),
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DoctorSendNotifications(
                                                      patientUID: patientUID)));
                                    },
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.bell_solid,
                                          color: MyColors.white,
                                        ),
                                        MySpaces.hGapInBetween,
                                        MyFonts().heading2('Send Notification',
                                            MyColors.white),
                                      ],
                                    ),
                                    color: MyColors.redLighter,
                                  ),
                                ],
                              ),
                              MySpaces.vSmallGapInBetween,
                              MyFonts().heading1('Personal', MyColors.black),
                              MySpaces.vGapInBetween,
                              _getRow('DOB', formatDateTime(userData['DOB'])),
                              _getRow('Age', userData['Age']),
                              _getRow('Gender', userData['Gender']),
                              _getRow('Phone Number', userData['PhoneNumber']),
                              _getRow(
                                  'Email Address', userData['EmailAddress']),
                              _getRow(
                                  'Residential Address', userData['Address']),
                              _getRow('Sign-up Date', formatDateTime(userData['SignUpDate'])),
                              MySpaces.vSmallGapInBetween,
                              MyFonts()
                                  .heading1('Medical History', MyColors.black),
                              MySpaces.vGapInBetween,
                              _getRow(
                                  'Illness',
                                  userData['Illness'] == ''
                                      ? 'No Data Available'
                                      : userData['Illness']),
                              _getRow(
                                  'Allergies',
                                  userData['Allergies'] == ''
                                      ? 'No Data Available'
                                      : userData['Allergies']),
                              _getRow(
                                  'Genetic Diseases',
                                  userData['GeneticDiseases'] == ''
                                      ? 'No Data Available'
                                      : userData['GeneticDiseases']),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MonitorPatientHealth(
                                                          patientUID:
                                                              patientUID,
                                                        )));
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            EvaIcons.activityOutline,
                                            color: MyColors.blueLighter,
                                          ),
                                          MySpaces.hGapInBetween,
                                          MyFonts().heading2(
                                              'Monitor Patient Health',
                                              MyColors.blueLighter),
                                        ],
                                      ),
                                      color: MyColors.white,
                                    ),
                                  ),
                                ],
                              ),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.offline_share_rounded,
                                            color: MyColors.white,
                                          ),
                                          MySpaces.hGapInBetween,
                                          MyFonts().heading2(
                                              'Transfer Patient',
                                              MyColors.white),
                                        ],
                                      ),
                                      color: MyColors.redLighter,
                                    ),
                                  ),
                                ],
                              ),
                              MySpaces.vLargeGapInBetween,
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      );
    });
  }
}
