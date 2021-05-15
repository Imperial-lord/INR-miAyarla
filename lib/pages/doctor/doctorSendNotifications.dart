import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fifthBackground.dart';
import 'package:health_bag/widgets/multilineRow.dart';
import 'package:provider/provider.dart';

class DoctorSendNotifications extends StatefulWidget {
  static String id = 'doctor-send-notifications';
  final String patientUID;
  DoctorSendNotifications({@required this.patientUID});

  @override
  createState() => _DoctorSendNotificationsState(patientUID: patientUID);
}

class _DoctorSendNotificationsState extends State<DoctorSendNotifications> {
  final String patientUID;
  _DoctorSendNotificationsState({@required this.patientUID});

  TextEditingController notificationTitleController =
      new TextEditingController();
  TextEditingController notificationBodyController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var doctorUID = loginStore.firebaseUser.uid;
      return Scaffold(
          body: SafeArea(
        child: Stack(children: [
          FifthBackground(),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: 20,
              right: 20,
            ),
            child: MyFonts().title1(MyStrings().doctorSendNotificationsHeading, MyColors.white),
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
                  children: [
                    MultilineRow().getMultilineRow(
                        MyStrings().doctorSendNotificationsTitle,
                        MyStrings().doctorSendNotificationsTitleDesc,
                        Icon(CupertinoIcons.textbox),
                        notificationTitleController,
                        TextInputType.multiline,
                        2,
                        true),
                    MultilineRow().getMultilineRow(
                        MyStrings().doctorSendNotificationsBody,
                        MyStrings().doctorSendNotificationsBodyDesc,
                        Icon(CupertinoIcons.text_quote),
                        notificationBodyController,
                        TextInputType.multiline,
                        5,
                        true),
                    MySpaces.vMediumGapInBetween,
                    Row(
                      children: [
                        Expanded(
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: () {
                              FirebaseFirestore firestoreInstance =
                                  FirebaseFirestore.instance;
                              firestoreInstance
                                  .collection('Notifications')
                                  .doc()
                                  .set({
                                'DoctorUID': doctorUID,
                                'PatientUID': patientUID,
                                'Title': notificationTitleController.text,
                                'Body': notificationBodyController.text,
                                'TimeOfCreation': DateTime.now(),
                              });
                              FirebaseFirestore firestoreInstance1 = FirebaseFirestore.instance;
                              firestoreInstance1
                                  .collection('Notification Bubbles')
                                  .doc(patientUID)
                                  .set({'bubble': true});
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(15),
                            child: MyFonts()
                                .heading1(MyStrings().doctorSendNotificationButtonText, MyColors.white),
                            color: MyColors.blueLighter,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ));
    });
  }
}
