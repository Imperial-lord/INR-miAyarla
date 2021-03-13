import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorManagement.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:health_bag/stores/login_store.dart';

import 'doctorManagement.dart';

class DoctorUploadPhoto extends StatefulWidget {
  static String id = 'doctor-upload-photo';

  @override
  _DoctorUploadPhotoState createState() => _DoctorUploadPhotoState();
}

class _DoctorUploadPhotoState extends State<DoctorUploadPhoto> {
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
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Stack(
                  children: [
                    ThirdBackground(),
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.16),
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
                                      .largeTitle('Smile ', MyColors.black),
                                  MyFonts().largeTitle(
                                      'Please! 😇', MyColors.blueLighter),
                                ],
                              ),
                              MyFonts().heading2(
                                  "We are almost done! We just need you to upload a profile picture.",
                                  MyColors.gray),
                              MySpaces.vSmallestGapInBetween,
                              MyFonts().subHeadline(
                                  "Kindly upload a photo of size < 2 MB",
                                  MyColors.blueLighter),
                              MySpaces.vLargeGapInBetween,
                              Stack(
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      backgroundImage: (avatarImageFile == null)
                                          ? AssetImage(
                                          'assets/icons/doctor.png')
                                          : FileImage(avatarImageFile),
                                      radius: 100,
                                      backgroundColor: MyColors.redLighter,
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
                              MySpaces.vLargeGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, DoctorManagement.id);
                                      },
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          MyFonts().heading1('Save and proceed',
                                              MyColors.white),
                                          MySpaces.hSmallestGapInBetween,
                                          Icon(EvaIcons.arrowRight,
                                              color: MyColors.white),
                                        ],
                                      ),
                                      color: MyColors.blueLighter,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
