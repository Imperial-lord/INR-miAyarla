import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/userTypeValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/common/welcome.dart';
import 'package:health_bag/pages/doctor/doctorManagement.dart';
import 'package:health_bag/pages/patients/patientManagement.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  static String id = 'splash';

  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) async {
      if (result) {
        User firebaseUser = FirebaseAuth.instance.currentUser;
        String uid = (firebaseUser.uid);
        print(uid);
        bool isDoctor = (await UserTypeValidation().isUserRegDoctor(uid));
        bool isPatient = (await UserTypeValidation().isUserRegPatient(uid));
        if (isDoctor) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => DoctorManagement()),
              (Route<dynamic> route) => false);
        } else if (isPatient) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => PatientManagement()),
              (Route<dynamic> route) => false);
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => Welcome()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          color: MyColors.blue,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/icons/blood-drop.png'),
                  height: 100,
                  width: 100,
                ),
                MySpaces.vMediumGapInBetween,
                MyFonts().largeTitle("INR'mi Ayarla", MyColors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
