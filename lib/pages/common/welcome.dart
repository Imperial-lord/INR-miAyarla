import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';

class Welcome extends StatefulWidget{
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome>{
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
                        MyFonts().largeTitle('Welcome', MyColors.black),
                        Row(
                          children: [
                            MyFonts().largeTitle('to ', MyColors.black),
                            MyFonts().largeTitle('HealthBag', MyColors.blueLighter),
                          ],
                        ),
                        MySpaces.vSmallGapInBetween,
                        MyFonts().heading2('The one-stop solution for all your health needs. Get in touch with your doctors right from your phone!', MyColors.gray),
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
        onPressed: (){},
        elevation: 0,
        child: Icon(EvaIcons.arrowCircleRight, size: 40,),
        backgroundColor: MyColors.red,
      )
    );
  }
}