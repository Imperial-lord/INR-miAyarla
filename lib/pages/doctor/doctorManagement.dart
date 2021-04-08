import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/pages/common/aboutApp.dart';
import 'package:health_bag/pages/doctor/addMoreDoctors.dart';
import 'package:health_bag/pages/doctor/doctorHome.dart';
import 'package:health_bag/pages/doctor/doctorProfile.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:provider/provider.dart';

class DoctorManagement extends StatefulWidget {
  static String id = 'doctor-management';

  @override
  _DoctorManagementState createState() => _DoctorManagementState();
}

class _DoctorManagementState extends State<DoctorManagement> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      List<Widget> pages = [
        DoctorHome(
          doctorUID: loginStore.firebaseUser.uid,
        ),
        DoctorProfile(),
        AddMoreDoctors(),
        AboutApp(),
      ];
      return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: MyColors.white,
          selectedIndex: _selectedIndex,
          onItemSelected: (index) async {
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
                  CupertinoIcons.house_fill,
                )),
            BottomNavyBarItem(
                inactiveColor: MyColors.gray,
                activeColor: MyColors.blueLighter,
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: MyFonts().subHeadline('Profile', MyColors.blueLighter),
                ),
                icon: Icon(
                  CupertinoIcons.person_alt,
                )),
            BottomNavyBarItem(
                inactiveColor: MyColors.gray,
                activeColor: MyColors.blueLighter,
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: MyFonts()
                      .subHeadline('Add Doctors', MyColors.blueLighter),
                ),
                icon: Icon(
                  CupertinoIcons.person_add_solid,
                )),
            BottomNavyBarItem(
                inactiveColor: MyColors.gray,
                activeColor: MyColors.blueLighter,
                title: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: MyFonts().subHeadline('About', MyColors.blueLighter),
                ),
                icon: Icon(
                  CupertinoIcons.info_circle_fill,
                )),
          ],
        ),
      );
    });
  }
}
