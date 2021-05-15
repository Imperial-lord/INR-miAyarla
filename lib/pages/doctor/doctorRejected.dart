import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:provider/provider.dart';

class DoctorRejected extends StatefulWidget {
  static String id = 'doctor-rejected';

  @override
  _DoctorRejectedState createState() => _DoctorRejectedState();
}

class _DoctorRejectedState extends State<DoctorRejected> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/icons/remove.png'),
                    height: 150,
                    width: 150,
                  ),
                  MySpaces.vLargeGapInBetween,
                  MyFonts().title1(MyStrings().doctorRejectedDB,
                      MyColors.redLighter),
                  MyFonts().body(
                      MyStrings().doctorRejectedSecurity,
                      MyColors.gray),
                  MySpaces.vLargeGapInBetween,
                  MyFonts().title1(MyStrings().doctorRejectedYouPatient, MyColors.black),
                  MySpaces.vGapInBetween,
                  Row(
                    children: [
                      // ignore: deprecated_member_use
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyFonts()
                                  .heading1(MyStrings().doctorRejectedContinueAsPatient, MyColors.white),
                              MySpaces.hSmallestGapInBetween,
                              Icon(EvaIcons.arrowRight, color: MyColors.white),
                            ],
                          ),
                          color: MyColors.blueLighter,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
