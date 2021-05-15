import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/validations/doctorValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/doctor/doctorApproved.dart';
import 'package:health_bag/pages/doctor/doctorRejected.dart';
import 'package:health_bag/pages/patients/patientReg.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';
import 'package:provider/provider.dart';

List<Color> bodyColor = [MyColors.white, MyColors.white];
List<Color> contentColor = [MyColors.gray, MyColors.gray];

class UserType extends StatefulWidget {
  static String id = 'user-type';

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: SafeArea(
            child: Material(
              child: Stack(
                children: [
                  FirstBackground(),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyFonts().largeTitle(
                            MyStrings().userTypeTellUsMore, MyColors.black),
                        MyFonts().largeTitle(
                            MyStrings().userTypeAboutYou, MyColors.blueLighter),
                        MySpaces.vSmallGapInBetween,
                        MyFonts().heading2(
                            MyStrings().userTypeWhoAreYou, MyColors.gray),
                        MySpaces.vLargeGapInBetween,
                        MySpaces.vMediumGapInBetween,
                        Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    if (bodyColor[0] == MyColors.white) {
                                      bodyColor[0] = MyColors.red;
                                      contentColor[0] = MyColors.white;
                                      // make the other button unselected!
                                      bodyColor[1] = MyColors.white;
                                      contentColor[1] = MyColors.gray;
                                    } else {
                                      bodyColor[0] = MyColors.white;
                                      contentColor[0] = MyColors.gray;
                                    }
                                  });
                                },
                                elevation: 10,
                                padding: EdgeInsets.symmetric(vertical: 60),
                                color: bodyColor[0],
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/doctorIcon.png'),
                                      color: contentColor[0],
                                      height: 64,
                                      width: 64,
                                    ),
                                    MySpaces.vSmallGapInBetween,
                                    MyFonts().heading1(
                                        MyStrings().userTypeDoctor,
                                        contentColor[0]),
                                  ],
                                ),
                              ),
                            ),
                            MySpaces.hMediumGapInBetween,
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    if (bodyColor[1] == MyColors.white) {
                                      bodyColor[1] = MyColors.red;
                                      contentColor[1] = MyColors.white;
                                      // make the other button unselected!
                                      bodyColor[0] = MyColors.white;
                                      contentColor[0] = MyColors.gray;
                                    } else {
                                      bodyColor[1] = MyColors.white;
                                      contentColor[1] = MyColors.gray;
                                    }
                                  });
                                },
                                elevation: 10,
                                padding: EdgeInsets.symmetric(vertical: 60),
                                color: bodyColor[1],
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/icons/patientIcon.png'),
                                      color: contentColor[1],
                                      height: 64,
                                      width: 64,
                                    ),
                                    MySpaces.vSmallGapInBetween,
                                    MyFonts().heading1(
                                        MyStrings().userTypePatient,
                                        contentColor[1]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            children: [
              MySpaces.hLargeGapInBetween,
              FloatingActionButton(
                heroTag: null,
                elevation: 0,
                onPressed: () {
                  loginStore.signOut(context);
                },
                child: Icon(
                  EvaIcons.arrowCircleLeft,
                  size: 40,
                ),
                backgroundColor: MyColors.blueLighter,
              ),
              Spacer(),
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  if (bodyColor[0] == MyColors.red) {
                    // Before sending to approve/not first see if the doctor indeed exists in database.
                    User firebaseUser = loginStore.firebaseUser;
                    print(firebaseUser.phoneNumber);
                    bool isValidDoc = await DoctorValidation()
                        .canDoctorGetApproved(firebaseUser);
                    if (isValidDoc)
                      Navigator.pushNamed(context, DoctorApproved.id);
                    else
                      Navigator.pushNamed(context, DoctorRejected.id);
                  } else if (bodyColor[1] == MyColors.red)
                    Navigator.pushNamed(context, PatientReg.id);
                  else {
                    final noTypeSelectedSnackBar = SnackBar(
                        backgroundColor: MyColors.black,
                        content: MyFonts().body(
                            MyStrings().userTypeSnackBar, MyColors.white));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(noTypeSelectedSnackBar);
                  }
                },
                elevation: 0,
                child: Icon(
                  EvaIcons.arrowCircleRight,
                  size: 40,
                ),
                backgroundColor: MyColors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}
