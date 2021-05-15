import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/doctor/doctorEditProfile.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorProfile extends StatefulWidget {
  static String id = 'doctor-profile';

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

Widget _getRow(String key, String val) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFonts().heading2(key, MyColors.blueLighter),
          MySpaces.hLargeGapInBetween,
          Flexible(child: Text(
            val,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'poppins-semi',
              fontSize: 15,
              color: MyColors.gray,
            ),
          )),
        ],
      ),
      Divider(),
    ],
  );
}

Widget _logoutPopup(BuildContext context, LoginStore loginStore) {
  return new AlertDialog(
    title: MyFonts().heading1(MyStrings().doctorProfileLogoutSure, MyColors.black),
    actions: <Widget>[
      // ignore: deprecated_member_use
      FlatButton(
        onPressed: () {
          loginStore.signOut(context);
        },
        child: MyFonts().heading2(MyStrings().doctorProfileLogout, MyColors.blueLighter),
      ),
      // ignore: deprecated_member_use
      FlatButton(
        color: MyColors.backgroundColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: MyFonts().heading2(MyStrings().doctorProfileNo, MyColors.blueLighter),
      ),
    ],
  );
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var uid = loginStore.firebaseUser.uid;
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
                child: MyFonts().title1(MyStrings().doctorProfileYourProfile, MyColors.white),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Doctors')
                          .doc(uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          // Store all the user data obtained from FireStore inside this map.
                          var userProfileData = snapshot.data.data();
                          userProfileData.forEach((k, v) {
                            if (v == '')
                              userProfileData[k] = MyStrings().doctorProfileNoDataAvailable;
                          });

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyFonts().heading1(MyStrings().doctorProfileProfileDetails, MyColors.black),
                              MySpaces.vGapInBetween,
                              Center(
                                child: CircleAvatar(
                                  backgroundImage: (userProfileData['Photo'] == null)
                                      ? AssetImage(
                                      'assets/icons/doctor.png')
                                      : NetworkImage(userProfileData['Photo']),
                                  radius: 100,
                                ),
                              ),
                              MySpaces.vGapInBetween,
                              _getRow(MyStrings().doctorProfileName, userProfileData['Name']),
                              _getRow(MyStrings().doctorProfilePhoneNumber,
                                  userProfileData['PhoneNumber']),
                              _getRow(MyStrings().doctorProfileSpecialisation,
                                  userProfileData['Specialisation']),
                              _getRow(MyStrings().doctorProfileHospitalName,
                                  userProfileData['HospitalName']),
                              _getRow(MyStrings().doctorProfileCityName,
                                  userProfileData['CityName']),
                              _getRow(MyStrings().doctorProfileDepartmentName,
                                  userProfileData['DepartmentName']),
                              _getRow(MyStrings().doctorProfileSignUpDate,
                                  formatDateTime(userProfileData['SignUpDate'])),
                              MySpaces.vLargeGapInBetween,
                              RaisedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => DoctorEditProfile(userProfileData),
                                  ));
                                },
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.edit,
                                      color: MyColors.white,
                                    ),
                                    MySpaces.hGapInBetween,
                                    MyFonts().heading2(
                                        MyStrings().doctorProfileEditProfile, MyColors.white),
                                  ],
                                ),
                                color: MyColors.blueLighter,
                              ),
                              MySpaces.vGapInBetween,
                              RaisedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => _logoutPopup(context, loginStore),
                                  );
                                },
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      EvaIcons.logOut,
                                      color: MyColors.white,
                                    ),
                                    MySpaces.hGapInBetween,
                                    MyFonts()
                                        .heading2(MyStrings().doctorProfileLogOut, MyColors.white),
                                  ],
                                ),
                                color: MyColors.redLighter,
                              ),
                              MySpaces.vSmallGapInBetween,
                            ],
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
