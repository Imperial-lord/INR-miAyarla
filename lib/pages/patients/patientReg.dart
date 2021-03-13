import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/functions/formValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/patients/uploadPhoto.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/loader_hud.dart';
import 'package:provider/provider.dart';

class PatientReg extends StatefulWidget {
  static String id = 'patient-reg';

  @override
  _PatientRegState createState() => _PatientRegState();
}

Widget _getRowPatientReg(
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

DateTime selectedDate = DateTime.now();

class _PatientRegState extends State<PatientReg> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController illnessController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  TextEditingController geneticController = TextEditingController();
  TextEditingController signUpDateController = TextEditingController();

  // Open a mini calendar to make the user select the date:
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.blueLighter,
            ),
          ),
          child: child,
        );
      },
      initialDate: selectedDate,
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dobController.text = picked.toString().split(' ')[0];
        ageController.text =
            (max((DateTime.now().difference(picked).inDays / 365).floor(), 0))
                .toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    signUpDateController.text = DateTime.now().toString().split(' ')[0];
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        String number = loginStore.firebaseUser.phoneNumber;
        phoneNumberController.text = number.substring(0,3)+'-'+number.substring(3,);
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isOtpLoading,
            child: Scaffold(
              key: loginStore.patientRegKey,
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
                              _getRowPatientReg(
                                  'Your full name',
                                  'Enter your name',
                                  Icon(EvaIcons.personOutline),
                                  nameController,
                                  TextInputType.name,
                                  1,
                                  true),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: MyFonts().heading2(
                                          'Your date of birth', MyColors.gray),
                                    ),
                                    CupertinoTextField(
                                      enabled: false,
                                      expands: false,
                                      padding: EdgeInsets.all(15),
                                      maxLines: 1,
                                      placeholder: 'Select a date',
                                      decoration: BoxDecoration(
                                          color: MyColors.backgroundColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          EvaIcons.calendarOutline,
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontFamily: 'poppins-semi',
                                          fontSize: 17,
                                          color: MyColors.black),
                                      controller: dobController,
                                      keyboardType: TextInputType.datetime,
                                    ),
                                  ],
                                ),
                              ),
                              _getRowPatientReg(
                                  'Your age',
                                  'Enter your age',
                                  Icon(EvaIcons.menu),
                                  ageController,
                                  TextInputType.number,
                                  1,
                                  false),
                              _getRowPatientReg(
                                  'Your gender',
                                  'Enter Male / Female / Other',
                                  Icon(EvaIcons.paperPlane),
                                  genderController,
                                  TextInputType.text,
                                  1,
                                  true),
                              _getRowPatientReg(
                                  'Your phone number',
                                  'Enter your phone number',
                                  Icon(EvaIcons.phoneCallOutline),
                                  phoneNumberController,
                                  TextInputType.number,
                                  1,
                                  false),
                              _getRowPatientReg(
                                  'Your email address',
                                  'Enter your email',
                                  Icon(EvaIcons.emailOutline),
                                  emailController,
                                  TextInputType.emailAddress,
                                  1,
                                  true),
                              _getRowPatientReg(
                                  'Your residence address',
                                  'Enter your complete address',
                                  Icon(CupertinoIcons.location),
                                  addressController,
                                  TextInputType.streetAddress,
                                  3,
                                  true),
                              _getRowPatientReg(
                                  'Your ailments',
                                  'What diseases are you suffering from?',
                                  Icon(Icons.local_hospital_outlined),
                                  illnessController,
                                  TextInputType.text,
                                  4,
                                  true),
                              _getRowPatientReg(
                                  'Your allergies',
                                  'Do you have any specific allergies?',
                                  Icon(CupertinoIcons.doc),
                                  allergyController,
                                  TextInputType.text,
                                  4,
                                  true),
                              _getRowPatientReg(
                                  'Your genetic disorders',
                                  'Do you have any genetic disorders?',
                                  Icon(Icons.account_tree_outlined),
                                  geneticController,
                                  TextInputType.text,
                                  4,
                                  true),
                              Visibility(
                                visible: false,
                                child: _getRowPatientReg(
                                    'Your sign up date',
                                    "Today's date",
                                    Icon(EvaIcons.calendarOutline),
                                    signUpDateController,
                                    TextInputType.datetime,
                                    1,
                                    false),
                              ),
                              MySpaces.vMediumGapInBetween,
                              Row(children: [
                                Expanded(
                                    child: RaisedButton(
                                  onPressed: () {
                                    // List of fields that should not be empty
                                    List<TextEditingController> controllers = [
                                      nameController,
                                      dobController,
                                      genderController,
                                      emailController,
                                      addressController
                                    ];
                                    if (FormValidation()
                                        .emptyFieldsValidation(controllers))
                                      loginStore.patientRegKey.currentState
                                          .showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: MyColors.black,
                                            content: MyFonts().body(
                                                'One or more fields are empty',
                                                MyColors.white)),
                                      );
                                    else if (FormValidation()
                                        .ageValidation(ageController.text))
                                      loginStore.patientRegKey.currentState
                                          .showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: MyColors.black,
                                            content: MyFonts().body(
                                                'Please enter a valid date of birth',
                                                MyColors.white)),
                                      );
                                    else if (FormValidation()
                                        .emailValidation(emailController.text))
                                      loginStore.patientRegKey.currentState
                                          .showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: MyColors.black,
                                            content: MyFonts().body(
                                                'Please enter a valid email',
                                                MyColors.white)),
                                      );
                                    else {
                                      // TODO: Later add data to FireStore from here!
                                      final firestoreInstance = FirebaseFirestore.instance;
                                      String uid = loginStore.firebaseUser.uid;
                                      print(uid);
                                      firestoreInstance.collection('Patients').doc(uid).set({
                                        'Photo': 'https://i.ibb.co/THPy5z3/patient.png',
                                        'Name':nameController.text,
                                        'DOB': dobController.text,
                                        'Age': ageController.text,
                                        'Gender': genderController.text,
                                        'PhoneNumber': phoneNumberController.text,
                                        'EmailAddress':emailController.text,
                                        'Address': addressController.text,
                                        'Illness': illnessController.text,
                                        'Allergies':allergyController.text,
                                        'GeneticDiseases':geneticController.text,
                                        'SignUpDate': signUpDateController.text,
                                      }).then((value) => print('Successfully added new patient data'));
                                      Navigator.pushNamed(context, UploadPhoto.id);
                                    }
                                  },
                                  padding: EdgeInsets.all(15),
                                  child: MyFonts()
                                      .heading1('Submit', MyColors.white),
                                  color: MyColors.blueLighter,
                                )),
                              ]),
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
