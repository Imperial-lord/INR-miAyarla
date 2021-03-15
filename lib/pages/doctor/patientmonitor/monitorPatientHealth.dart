import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/patientmonitor/addMedicines.dart';
import 'package:health_bag/pages/doctor/patientmonitor/addVisitDates.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

import 'addDoctorNotes.dart';

class MonitorPatientHealth extends StatefulWidget {
  static String id = 'monitor-patient-health';

  @override
  _MonitorPatientHealthState createState() => _MonitorPatientHealthState();
}

Widget _getRow(String key, String val) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFonts().heading2(key, MyColors.blueLighter),
          MySpaces.hLargeGapInBetween,
          Flexible(child: MyFonts().heading2(val, MyColors.gray)),
        ],
      ),
      Divider(),
    ],
  );
}

class _MonitorPatientHealthState extends State<MonitorPatientHealth> {
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
                child: MyFonts().title1("Prashant's Health 📈", MyColors.white),
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
                      AddDoctorNotes(),
                      AddVisitDates(),
                      AddMedicines(),
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
