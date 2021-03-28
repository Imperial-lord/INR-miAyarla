import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/loaderHud.dart';
import 'package:provider/provider.dart';

class PatientNotifications extends StatefulWidget {
  static String id = 'patient-notifications';

  @override
  _PatientNotificationsState createState() => _PatientNotificationsState();
}

class _PatientNotificationsState extends State<PatientNotifications> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyFonts().title1('Your notifications', MyColors.white),
                    ],
                  ),
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
                      children: <Widget>[
                        MyFonts().heading2('You will receive push notifications at the appropriate time', MyColors.gray),
                        MySpaces.vGapInBetween,
                        for(int i=0;i<3;i++)
                          Card(
                            elevation: 3,
                            child: ListTile(
                              leading: Container(height:double.infinity,child: Icon(Icons.notifications_active, color: MyColors.redLighter)),
                              title: MyFonts().heading2('Upcoming Notifications', MyColors.blueLighter),
                              subtitle: MyFonts().body('9:00 AM Saturday', MyColors.gray),
                            ),
                          ),
                        for(int i=0;i<6;i++)
                          Card(
                            child: ListTile(
                              leading: Container(height:double.infinity,child: Icon(Icons.notifications_active, color: MyColors.redLightest,)),
                              title: MyFonts().heading2('Past Notifications', MyColors.blueLightest),
                              subtitle: MyFonts().body('9:00 AM Friday', MyColors.gray.withOpacity(0.5)),
                            ),
                          ),
                        MySpaces.vSmallGapInBetween,
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
