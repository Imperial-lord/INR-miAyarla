import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorReg.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:provider/provider.dart';

class DoctorApproved extends StatefulWidget {
  static String id = 'doctor-approved';

  @override
  _DoctorApprovedState createState() => _DoctorApprovedState();
}

class _DoctorApprovedState extends State<DoctorApproved> {

  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushNamed(context, DoctorReg.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      return Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/icons/check.png'),
                  height: 150,
                  width: 150,
                ),
                MySpaces.vLargeGapInBetween,
                MyFonts().largeTitle('Approved!', MyColors.gray),
              ],
            ),
          ),
        ),
      );
    });
  }
}
