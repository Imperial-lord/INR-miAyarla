import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/pages/common/aboutApp.dart';
import 'package:health_bag/pages/patients/patientHome.dart';
import 'package:health_bag/pages/patients/patientNotifications.dart';
import 'package:health_bag/pages/patients/patientProfile.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/loaderHud.dart';
import 'package:provider/provider.dart';

class PatientManagement extends StatefulWidget {
  static String id = 'patient-management';

  @override
  _PatientManagementState createState() => _PatientManagementState();
}

class _PatientManagementState extends State<PatientManagement> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      PatientHome(),
      PatientNotifications(),
      PatientProfile(),
      AboutApp(),
    ];
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
        return Scaffold(
          body: pages[_selectedIndex],
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: MyColors.white,
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavyBarItem(
                  inactiveColor: MyColors.gray,
                  activeColor: MyColors.blueLighter,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MyFonts().subHeadline('Home', MyColors.blueLighter),
                  ),
                  icon: Icon(
                    EvaIcons.homeOutline,
                  )),
              BottomNavyBarItem(
                  inactiveColor: MyColors.gray,
                  activeColor: MyColors.blueLighter,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MyFonts().subHeadline('Notifications', MyColors.blueLighter),
                  ),
                  icon: Icon(
                    EvaIcons.bellOutline,
                  )
              ),
              BottomNavyBarItem(
                  inactiveColor: MyColors.gray,
                  activeColor: MyColors.blueLighter,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MyFonts().subHeadline('Profile', MyColors.blueLighter),
                  ),
                  icon: Icon(
                    EvaIcons.personOutline,
                  )
              ),
              BottomNavyBarItem(
                  inactiveColor: MyColors.gray,
                  activeColor: MyColors.blueLighter,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: MyFonts().subHeadline('About', MyColors.blueLighter),
                  ),
                  icon: Icon(
                    EvaIcons.infoOutline,
                  )
              ),
            ],
          ),
        );
    });
  }
}
