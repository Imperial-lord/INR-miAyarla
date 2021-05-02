import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/validations/formValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorManagement.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DoctorEditProfile extends StatefulWidget {
  static String id = 'patient-edit-profile';
  var userProfileData;

  DoctorEditProfile(this.userProfileData);

  @override
  _DoctorEditProfileState createState() =>
      _DoctorEditProfileState(userProfileData);
}

Widget _getRowDoctorEditProfile(
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

class _DoctorEditProfileState extends State<DoctorEditProfile> {
  var userProfileData;

  _DoctorEditProfileState(this.userProfileData);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController specialisationController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController signUpDateController = TextEditingController();

  // Update Image in Edit Profile
  File avatarImageFile;
  bool isLoading = false;

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 75);
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
      firestoreInstance.collection('Doctors').doc(uid).update({'Photo': url});
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
    specialisationController.text = setControllerText(
        specialisationController, userProfileData['Specialisation']);
    hospitalController.text =
        setControllerText(hospitalController, userProfileData['HospitalName']);
    cityController.text =
        setControllerText(cityController, userProfileData['CityName']);
    deptController.text =
        setControllerText(deptController, userProfileData['DepartmentName']);
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
                          _getRowDoctorEditProfile(
                              'Your full name',
                              'Enter your name',
                              Icon(EvaIcons.personOutline),
                              nameController,
                              TextInputType.name,
                              1,
                              true),
                          _getRowDoctorEditProfile(
                              'Your phone number',
                              'Enter your phone number',
                              Icon(EvaIcons.phoneCallOutline),
                              phoneNumberController,
                              TextInputType.number,
                              1,
                              false),
                          _getRowDoctorEditProfile(
                              'Your specialisation',
                              'What do you specialise in?',
                              Icon(EvaIcons.shoppingBagOutline),
                              specialisationController,
                              TextInputType.text,
                              2,
                              true),
                          _getRowDoctorEditProfile(
                              'Hospital Name',
                              'Which hospital do you work in?',
                              Icon(Icons.local_hospital_outlined),
                              hospitalController,
                              TextInputType.text,
                              2,
                              true),
                          _getRowDoctorEditProfile(
                              'Your City Name',
                              'Enter your city name',
                              Icon(CupertinoIcons.building_2_fill),
                              cityController,
                              TextInputType.text,
                              1,
                              true),
                          _getRowDoctorEditProfile(
                              'Your Department Name',
                              'Enter your department name',
                              Icon(CupertinoIcons.home),
                              deptController,
                              TextInputType.text,
                              1,
                              true),
                          Visibility(
                            visible: true,
                            child: _getRowDoctorEditProfile(
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
                                  specialisationController,
                                  hospitalController,
                                  cityController,
                                  deptController,
                                ];
                                if (FormValidation()
                                    .emptyFieldsValidation(controllers)) {
                                  final emptyFieldSnackbar = SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: MyColors.black,
                                      content: MyFonts().body(
                                          'One or more fields are empty',
                                          MyColors.white));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(emptyFieldSnackbar);
                                } else {
                                  final firestoreInstance =
                                      FirebaseFirestore.instance;
                                  String uid = loginStore.firebaseUser.uid;
                                  print(uid);
                                  firestoreInstance
                                      .collection('Doctors')
                                      .doc(uid)
                                      .update({
                                    'Name': nameController.text,
                                    'PhoneNumber': phoneNumberController.text,
                                    'Specialisation':
                                        specialisationController.text,
                                    'HospitalName': hospitalController.text,
                                    'CityName': cityController.text,
                                    'DepartmentName': deptController.text,
                                    'SignUpDate': signUpDateController.text,
                                  }).then((value) => print(
                                          'Successfully added new doctor data'));
                                }
                                Navigator.pushNamed(
                                    context, DoctorManagement.id);
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
