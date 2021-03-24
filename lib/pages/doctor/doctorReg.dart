import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/functions/validations/formValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorUploadPhoto.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/loader_hud.dart';
import 'package:provider/provider.dart';

import 'doctorManagement.dart';

class DoctorReg extends StatefulWidget {
  static String id = 'doctor-reg';

  @override
  _DoctorRegState createState() => _DoctorRegState();
}

/*
* A sample Doctor card here -
* Dr. Elizabeth Owens
* Endocrinology,
* Hospital Name, City (or department)
* We need name, specialisation, hospital name, city, department.
*/

Widget _getRowDoctorReg(
    String heading,
    String placeholder,
    Icon icon,
    TextEditingController controller,
    TextInputType textInputType,
    int lines,
    bool toggleEnabled) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MyFonts().heading2(heading, MyColors.gray),
      ),
      CupertinoTextField(
        enabled: toggleEnabled,
        expands: false,
        padding: EdgeInsets.all(15),
        maxLines: lines,
        placeholder: placeholder,
        decoration: BoxDecoration(
            color: MyColors.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        prefix: Padding(padding: const EdgeInsets.all(10), child: icon),
        style: TextStyle(
            fontFamily: 'poppins-semi',
            fontSize: 17,
            color: (toggleEnabled) ? MyColors.black : MyColors.gray),
        controller: controller,
        keyboardType: textInputType,
      ),
    ],
  );
}

class _DoctorRegState extends State<DoctorReg> {
  // We need name, specialisation, hospital name, city, department.
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController specialisationController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController signUpDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    signUpDateController.text = DateTime.now().toString().split(' ')[0];
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        String number = loginStore.firebaseUser.phoneNumber;
        phoneNumberController.text = number.substring(0, 3) +
            '-' +
            number.substring(
              3,
            );
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isOtpLoading,
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    ThirdBackground(),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  MyFonts()
                                      .largeTitle('Hello ', MyColors.black),
                                  MyFonts().largeTitle(
                                      'there!', MyColors.blueLighter),
                                ],
                              ),
                              MyFonts().heading2(
                                  "Let's get you all set up!", MyColors.gray),
                              MySpaces.vGapInBetween,
                              _getRowDoctorReg(
                                  'Your full name',
                                  'Enter your name',
                                  Icon(EvaIcons.personOutline),
                                  nameController,
                                  TextInputType.name,
                                  1,
                                  true),
                              _getRowDoctorReg(
                                  'Your phone number',
                                  'Enter your phone number',
                                  Icon(EvaIcons.phoneCallOutline),
                                  phoneNumberController,
                                  TextInputType.number,
                                  1,
                                  false),
                              _getRowDoctorReg(
                                  'Your specialisation',
                                  'What do you specialise in?',
                                  Icon(EvaIcons.shoppingBagOutline),
                                  specialisationController,
                                  TextInputType.text,
                                  2,
                                  true),
                              _getRowDoctorReg(
                                  'Hospital Name',
                                  'Which hospital do you work in?',
                                  Icon(Icons.local_hospital_outlined),
                                  hospitalController,
                                  TextInputType.text,
                                  2,
                                  true),
                              _getRowDoctorReg(
                                  'Your City Name',
                                  'Enter your city name',
                                  Icon(CupertinoIcons.building_2_fill),
                                  cityController,
                                  TextInputType.text,
                                  1,
                                  true),
                              _getRowDoctorReg(
                                  'Your Department Name',
                                  'Enter your department name',
                                  Icon(CupertinoIcons.home),
                                  deptController,
                                  TextInputType.text,
                                  1,
                                  true),
                              Visibility(
                                visible: false,
                                child: _getRowDoctorReg(
                                    'Your sign up date',
                                    "Today's date",
                                    Icon(EvaIcons.calendarOutline),
                                    signUpDateController,
                                    TextInputType.datetime,
                                    1,
                                    false),
                              ),
                              MySpaces.vMediumGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      onPressed: () {
                                        // List of fields that should not be empty
                                        List<TextEditingController>
                                            controllers = [
                                          nameController,
                                          specialisationController,
                                          hospitalController,
                                          cityController,
                                          deptController,
                                        ];
                                        if (FormValidation()
                                            .emptyFieldsValidation(
                                                controllers)) {
                                          final emptyFieldSnackbar = SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: MyColors.black,
                                              content: MyFonts().body(
                                                  'One or more fields are empty',
                                                  MyColors.white));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(emptyFieldSnackbar);
                                        } else {
                                          final firestoreInstance = FirebaseFirestore.instance;
                                          String uid = loginStore.firebaseUser.uid;
                                          print(uid);
                                          firestoreInstance.collection('Doctors').doc(uid).set({
                                            'Photo': 'https://i.ibb.co/Jpttkc3/doctor.png',
                                            'Name':nameController.text,
                                            'PhoneNumber': phoneNumberController.text,
                                            'Specialisation': specialisationController.text,
                                            'HospitalName': hospitalController.text,
                                            'CityName': cityController.text,
                                            'DepartmentName': deptController.text,
                                            'SignUpDate': signUpDateController.text,
                                          }).then((value) => print('Successfully added new doctor data'));
                                        }
                                        Navigator.pushNamed(context, DoctorUploadPhoto.id);
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: MyFonts()
                                          .heading1('Submit', MyColors.white),
                                      color: MyColors.blueLighter,
                                    ),
                                  ),
                                ],
                              ),
                              MySpaces.vLargeGapInBetween,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
