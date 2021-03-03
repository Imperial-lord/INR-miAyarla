import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/common/home_page.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';

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
                      MyFonts().largeTitle('Tell us more', MyColors.black),
                      MyFonts().largeTitle('about you', MyColors.blueLighter),
                      MySpaces.vSmallGapInBetween,
                      MyFonts().heading2(
                          'Are you a doctor trying to cater to a patient\'s needs or a patient here for connecting with doctors?',
                          MyColors.gray),
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
                                  MyFonts().heading1('Doctor', contentColor[0]),
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
                                  MyFonts().heading1('Patient', contentColor[1]),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, HomePage.id);
          },
          elevation: 0,
          child: Icon(
            EvaIcons.arrowCircleRight,
            size: 40,
          ),
          backgroundColor: MyColors.red,
        ));
  }
}
