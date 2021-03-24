import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/formValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/patients/patientManagement.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:health_bag/widgets/multilineRow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PatientEditProfile extends StatefulWidget {
  static String id = 'patient-edit-profile';
  var userProfileData;

  PatientEditProfile(this.userProfileData);

  @override
  _PatientEditProfileState createState() =>
      _PatientEditProfileState(userProfileData);
}

Widget _getRowPatientEditProfile(
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

var map = {};

String setControllerText(
    TextEditingController controller, var userProfileData) {
  if (userProfileData == 'No data available') userProfileData = '';
  String ans;
  if (controller.text == '' && !map.containsKey(controller))
    ans = userProfileData;
  else
    ans = controller.text;
  map[controller] = true;
  return ans;
}

DateTime selectedDate = DateTime.now();
List<Color> bodyColor = [MyColors.white, MyColors.white];
List<Color> contentColor = [MyColors.gray, MyColors.gray];

class _PatientEditProfileState extends State<PatientEditProfile> {
  var userProfileData;

  _PatientEditProfileState(this.userProfileData);

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

  @override
  void initState() {
    super.initState();
    if (userProfileData['Gender'] == 'Male') {
      setState(() {
        bodyColor[0] = MyColors.redLighter;
        contentColor[0] = MyColors.white;
      });
    } else {
      setState(() {
        bodyColor[1] = MyColors.redLighter;
        contentColor[1] = MyColors.white;
      });
    }
  }

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

  // Update Image in Edit Profile
  File avatarImageFile;
  bool isLoading = false;

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    File image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
      return;
    }

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }

    // make sure that the picture size does not exceed 2 MB
    if (avatarImageFile.lengthSync() / (1024 * 1024) > 2) {
      setState(() {
        avatarImageFile = null;
        isLoading = false;
        final bigPhotoSnackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: MyColors.black,
            content: MyFonts()
                .body('Please choose a photo of size < 2 MB', MyColors.white));
        ScaffoldMessenger.of(context).showSnackBar(bigPhotoSnackBar);
      });
    } else
      uploadFile();
  }

  Future uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String uid = FirebaseAuth.instance.currentUser.uid;
    // ensures that each user occupies <= 2 MB in storage
    Reference ref = storage.ref().child("image_" + uid);
    UploadTask uploadTask = ref.putFile(avatarImageFile);
    uploadTask.whenComplete(() async {
      var url = await ref.getDownloadURL();
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection('Patients').doc(uid).update({'Photo': url});
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    nameController.text =
        setControllerText(nameController, userProfileData['Name']);
    dobController.text =
        setControllerText(dobController, userProfileData['DOB']);
    ageController.text =
        setControllerText(ageController, userProfileData['Age']);
    genderController.text =
        setControllerText(genderController, userProfileData['Gender']);
    emailController.text =
        setControllerText(emailController, userProfileData['EmailAddress']);
    addressController.text =
        setControllerText(addressController, userProfileData['Address']);
    illnessController.text =
        setControllerText(illnessController, userProfileData['Illness']);
    allergyController.text =
        setControllerText(allergyController, userProfileData['Allergies']);
    geneticController.text = setControllerText(
        geneticController, userProfileData['GeneticDiseases']);
    signUpDateController.text =
        setControllerText(signUpDateController, userProfileData['SignUpDate']);

    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        String number = loginStore.firebaseUser.phoneNumber;
        phoneNumberController.text = number.substring(0, 3) +
            '-' +
            number.substring(
              3,
            );
        return Scaffold(
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
                              MyFonts().largeTitle('Edit ', MyColors.black),
                              MyFonts()
                                  .largeTitle('Profile!', MyColors.blueLighter),
                            ],
                          ),
                          MySpaces.vGapInBetween,
                          Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundImage: (avatarImageFile == null)
                                      ? NetworkImage(userProfileData['Photo'])
                                      : FileImage(avatarImageFile),
                                  radius: 100,
                                ),
                              ),
                              Positioned(
                                right: 50,
                                bottom: 0,
                                child: CircleAvatar(
                                  child: IconButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    icon: Icon(
                                      CupertinoIcons.camera_fill,
                                      color: MyColors.black,
                                      size: 30,
                                    ),
                                  ),
                                  backgroundColor: MyColors.backgroundColor,
                                  radius: 30,
                                ),
                              )
                            ],
                          ),
                          MySpaces.vGapInBetween,
                          _getRowPatientEditProfile(
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                          _getRowPatientEditProfile(
                              'Your age',
                              'Enter your age',
                              Icon(EvaIcons.menu),
                              ageController,
                              TextInputType.number,
                              1,
                              false),
                          // _getRowPatientEditProfile(
                          //     'Your gender',
                          //     'Enter Male / Female / Other',
                          //     Icon(EvaIcons.paperPlane),
                          //     genderController,
                          //     TextInputType.text,
                          //     1,
                          //     true),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: MyFonts()
                                    .heading2('Your gender', MyColors.gray),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      child: MyFonts()
                                          .heading2('Male', contentColor[0]),
                                      onPressed: () {
                                        setState(() {
                                          if (bodyColor[0] == MyColors.white) {
                                            genderController.text = 'Male';
                                            bodyColor[0] = MyColors.redLighter;
                                            contentColor[0] = MyColors.white;
                                            // make the other button unselected!
                                            bodyColor[1] = MyColors.white;
                                            contentColor[1] = MyColors.gray;
                                          } else {
                                            genderController.text = '';
                                            bodyColor[0] = MyColors.white;
                                            contentColor[0] = MyColors.gray;
                                          }
                                        });
                                      },
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: bodyColor[0],
                                    ),
                                  ),
                                  MySpaces.hLargeGapInBetween,
                                  Expanded(
                                    child: RaisedButton(
                                      child: MyFonts()
                                          .heading2('Female', contentColor[1]),
                                      onPressed: () {
                                        setState(() {
                                          if (bodyColor[1] == MyColors.white) {
                                            genderController.text = 'Female';
                                            bodyColor[1] = MyColors.redLighter;
                                            contentColor[1] = MyColors.white;
                                            // make the other button unselected!
                                            bodyColor[0] = MyColors.white;
                                            contentColor[0] = MyColors.gray;
                                          } else {
                                            genderController.text = '';
                                            bodyColor[1] = MyColors.white;
                                            contentColor[1] = MyColors.gray;
                                          }
                                        });
                                      },
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      color: bodyColor[1],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          _getRowPatientEditProfile(
                              'Your phone number',
                              'Enter your phone number',
                              Icon(EvaIcons.phoneCallOutline),
                              phoneNumberController,
                              TextInputType.number,
                              1,
                              false),
                          _getRowPatientEditProfile(
                              'Your email address',
                              'Enter your email',
                              Icon(EvaIcons.emailOutline),
                              emailController,
                              TextInputType.emailAddress,
                              1,
                              true),
                          MultilineRow().getMultilineRow(
                              'Your residence address',
                              'Enter your complete address',
                              Icon(CupertinoIcons.location),
                              addressController,
                              TextInputType.streetAddress,
                              3,
                              true),
                          MultilineRow().getMultilineRow(
                              'Your ailments',
                              'What diseases are you suffering from?',
                              Icon(Icons.local_hospital_outlined),
                              illnessController,
                              TextInputType.multiline,
                              4,
                              true),
                          MultilineRow().getMultilineRow(
                              'Your allergies',
                              'Do you have any specific allergies?',
                              Icon(CupertinoIcons.doc),
                              allergyController,
                              TextInputType.multiline,
                              4,
                              true),
                          MultilineRow().getMultilineRow(
                              'Your genetic disorders',
                              'Do you have any genetic disorders?',
                              Icon(Icons.account_tree_outlined),
                              geneticController,
                              TextInputType.multiline,
                              4,
                              true),
                          Visibility(
                            visible: false,
                            child: _getRowPatientEditProfile(
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
                                    .emptyFieldsValidation(controllers)) {
                                  final emptyFieldsSnackbar = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: MyColors.black,
                                      content: MyFonts().body(
                                          'One or more fields are empty',
                                          MyColors.white));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(emptyFieldsSnackbar);
                                } else if (FormValidation()
                                    .ageValidation(ageController.text)) {
                                  final validDOBSnackBar = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: MyColors.black,
                                      content: MyFonts().body(
                                          'Please enter a valid date of birth',
                                          MyColors.white));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(validDOBSnackBar);
                                } else if (FormValidation()
                                    .emailValidation(emailController.text)) {
                                  final validEmailSnackBar = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: MyColors.black,
                                      content: MyFonts().body(
                                          'Please enter a valid email',
                                          MyColors.white));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(validEmailSnackBar);
                                } else {
                                  // TODO: Later add data to FireStore from here!
                                  final firestoreInstance =
                                      FirebaseFirestore.instance;
                                  String uid = loginStore.firebaseUser.uid;

                                  firestoreInstance
                                      .collection('Patients')
                                      .doc(uid)
                                      .update({
                                    'Name': nameController.text,
                                    'DOB': dobController.text,
                                    'Age': ageController.text,
                                    'Gender': genderController.text,
                                    'PhoneNumber': phoneNumberController.text,
                                    'EmailAddress': emailController.text,
                                    'Address': addressController.text,
                                    'Illness': illnessController.text,
                                    'Allergies': allergyController.text,
                                    'GeneticDiseases': geneticController.text,
                                    'SignUpDate': signUpDateController.text,
                                  }).then((value) => print(
                                          'Successfully added new patient data'));
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      PatientManagement.id,
                                      (Route<dynamic> route) => false);
                                }
                              },
                              padding: EdgeInsets.all(15),
                              child: MyFonts()
                                  .heading1('Update Profile', MyColors.white),
                              color: MyColors.blueLighter,
                            )),
                          ]),
                          MySpaces.vLargeGapInBetween,
                        ],
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  MyColors.blueLighter)),
                        ),
                        color: MyColors.white.withOpacity(0.8),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
