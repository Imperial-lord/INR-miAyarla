import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorPatientInterface extends StatefulWidget {
  static String id = 'doctor-patient-interface';

  @override
  _DoctorPatientInterfaceState createState() => _DoctorPatientInterfaceState();
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

class _DoctorPatientInterfaceState extends State<DoctorPatientInterface> {
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
                child: MyFonts().title1("Prashant's Profile", MyColors.white),
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
                              AssetImage('assets/icons/patient.png'),
                          radius: 60,
                        ),
                      ),
                      MySpaces.vSmallestGapInBetween,
                      Center(
                          child: MyFonts()
                              .heading1('Prashant Khatri', MyColors.black)),
                      MySpaces.vSmallGapInBetween,
                      Row(
                        children: [
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  EvaIcons.paperPlaneOutline,
                                  color: MyColors.white,
                                ),
                                MySpaces.hGapInBetween,
                                MyFonts().heading2('Chat', MyColors.white),
                              ],
                            ),
                            color: MyColors.blueLighter,
                          ),
                          Spacer(),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  EvaIcons.bellOutline,
                                  color: MyColors.white,
                                ),
                                MySpaces.hGapInBetween,
                                MyFonts().heading2(
                                    'Send Notification', MyColors.white),
                              ],
                            ),
                            color: MyColors.redLighter,
                          ),
                        ],
                      ),
                      MySpaces.vSmallGapInBetween,
                      MyFonts().heading1('Personal', MyColors.black),
                      MySpaces.vGapInBetween,
                      _getRow('DOB', '10-01-2000'),
                      _getRow('Age', '21'),
                      _getRow('Gender', 'Male'),
                      _getRow('Phone Number', '+91-8756715653'),
                      _getRow('Email Address', 'prashant@gmail.com'),
                      _getRow('Residential Address', 'Room 328, IIT Guwahati'),
                      _getRow('Sign-up Date', '13-04-2021'),
                      MySpaces.vSmallGapInBetween,
                      MyFonts().heading1('Medical History', MyColors.black),
                      MySpaces.vGapInBetween,
                      _getRow('Illness', 'Common Cold, Flu'),
                      _getRow('Allergies', 'None'),
                      _getRow('Genetic Diseases', 'None'),
                      MySpaces.vSmallGapInBetween,
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    EvaIcons.activityOutline,
                                    color: MyColors.blueLighter,
                                  ),
                                  MySpaces.hGapInBetween,
                                  MyFonts().heading2(
                                      'Monitor Patient Health', MyColors.blueLighter),
                                ],
                              ),
                              color: MyColors.white,
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
          ),
        ),
      );
    });
  }
}
