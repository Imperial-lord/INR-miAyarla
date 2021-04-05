import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/common/latestTestResults.dart';
import 'package:health_bag/pages/doctor/patientmonitor/addMedicines.dart';
import 'package:health_bag/pages/doctor/patientmonitor/addVisitDates.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

import 'addDoctorNotes.dart';

class MonitorPatientHealth extends StatefulWidget {
  static String id = 'monitor-patient-health';

  final String patientUID;

  MonitorPatientHealth({@required this.patientUID});

  @override
  _MonitorPatientHealthState createState() =>
      _MonitorPatientHealthState(patientUID: patientUID);
}

Widget _getRow(String key, String val) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFonts().heading2(key, MyColors.blueLighter),
          MySpaces.hLargeGapInBetween,
          Flexible(
              child: Text(
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

class _MonitorPatientHealthState extends State<MonitorPatientHealth> {
  final String patientUID;

  _MonitorPatientHealthState({@required this.patientUID});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var doctorUid = loginStore.firebaseUser.uid;
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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Patients')
                        .doc(patientUID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String title =
                            snapshot.data.data()['Name'].split(' ')[0];
                        return MyFonts()
                            .title1("$title's Health 📈", MyColors.white);
                      } else
                        return CircularProgressIndicator();
                    }),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AddDoctorNotes(patientUID: patientUID),
                      MySpaces.vMediumGapInBetween,
                      AddVisitDates(patientUID: patientUID),
                      MySpaces.vMediumGapInBetween,
                      AddMedicines(patientUID: patientUID),
                      MySpaces.vMediumGapInBetween,
                      LatestTestResults(patientUID: patientUID),
                      MySpaces.vMediumGapInBetween,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
