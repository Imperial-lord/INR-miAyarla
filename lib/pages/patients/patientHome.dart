import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class PatientHome extends StatefulWidget {
  static String id = 'patient-home';

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

Widget _medicineCard(String name) {
  return Expanded(
    child: Card(
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image(
                image: NetworkImage('https://i.ibb.co/fv0ztpr/medicine.png'),
                fit: BoxFit.contain,
              ),
              MyFonts().heading2(name, MyColors.blueLighter),
              MyFonts().body('Medicine Notes', MyColors.gray),
              MySpaces.vSmallestGapInBetween,
              MyFonts().subHeadline('9:00 AM  6:00 PM', MyColors.redLighter)
            ],
          ),
        )),
  );
}

class _PatientHomeState extends State<PatientHome> {
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
                                      return Row(
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
                                      );
                                    }
                                  }),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Icon(
                                          EvaIcons.paperPlaneOutline,
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
                                  RaisedButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      children: [
                                        Icon(
                                          EvaIcons.bellOutline,
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
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0; i < notes.length; i++)
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
                                              MyFonts().heading2(
                                                  dates['LastVisit'],
                                                  MyColors.redLighter)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              MyFonts().heading2(
                                                  '• Next Visit: ',
                                                  MyColors.blueLighter),
                                              MyFonts().heading2(
                                                  dates['NextVisit'],
                                                  MyColors.redLighter)
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  }),
                              MySpaces.vSmallGapInBetween,
                              MyFonts().heading1(
                                  'Current Medications', MyColors.black),
                              MySpaces.vGapInBetween,
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      _medicineCard('Paracetamol'),
                                      MySpaces.hSmallestGapInBetween,
                                      _medicineCard('Sinarest'),
                                    ],
                                  ),
                                  MySpaces.vSmallestGapInBetween,
                                  Row(
                                    children: [
                                      _medicineCard('Paracetamol'),
                                      MySpaces.hSmallestGapInBetween,
                                      _medicineCard('Sinarest'),
                                    ],
                                  ),
                                ],
                              ),
                              MySpaces.vSmallGapInBetween,
                              MyFonts().heading1(
                                  'Latest Test Results', MyColors.black),
                              MySpaces.vGapInBetween,
                              for (int i = 0; i < 2; i++)
                                Card(
                                  elevation: 3,
                                  child: ListTile(
                                    leading: Container(
                                        height: double.infinity,
                                        child:
                                            Icon(CupertinoIcons.doc_checkmark)),
                                    title: MyFonts().heading2(
                                        'Pregnancy Test', MyColors.blueLighter),
                                    subtitle: MyFonts().body(
                                        '9:00 AM Saturday', MyColors.gray),
                                    trailing: Icon(EvaIcons.downloadOutline),
                                  ),
                                ),
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
