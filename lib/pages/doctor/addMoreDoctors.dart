import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/patients/patientEditProfile.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/loader_hud.dart';
import 'package:provider/provider.dart';

class AddMoreDoctors extends StatefulWidget {
  static String id = 'add-more-doctors';

  @override
  _AddMoreDoctorsState createState() => _AddMoreDoctorsState();
}

class _AddMoreDoctorsState extends State<AddMoreDoctors> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
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
                child: MyFonts().title1('Add Doctors', MyColors.white),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
