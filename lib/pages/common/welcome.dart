import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';

import 'auth/signin.dart';

class Welcome extends StatefulWidget {
  static String id = 'welcome';
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Material(
            child: Stack(
              children: [
                FirstBackground(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyFonts().largeTitle(MyStrings().welcomeHeader, MyColors.black),
                          Row(
                            children: [
                              MyFonts().largeTitle(MyStrings().welcomeTo, MyColors.black),
                              MyFonts().largeTitle(
                                  "INR'mi Ayarla", MyColors.blueLighter),
                            ],
                          ),
                          MySpaces.vSmallGapInBetween,
                          MyFonts().heading2(
                              MyStrings().welcomeOneStopSol,
                              MyColors.gray),
                        ],
                      ),
                    ),
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/doctors.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SignIn.id);
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
