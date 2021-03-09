import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';

class AboutApp extends StatelessWidget {
  static String id = 'about-app';

  @override
  Widget build(BuildContext context) {
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
              child: MyFonts().title1('About App', MyColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
