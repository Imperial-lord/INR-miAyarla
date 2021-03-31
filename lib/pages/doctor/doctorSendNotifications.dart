import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorPatientInterface.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fifthBackground.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
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
  TextEditingController notificationAttachmentController =
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
            child: MyFonts().title1("Send a Notification", MyColors.white),
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
                        'Title',
                        'Add a notification title',
                        Icon(CupertinoIcons.textbox),
                        notificationTitleController,
                        TextInputType.multiline,
                        2,
                        true),
                    MultilineRow().getMultilineRow(
                        'Body',
                        'Add a notification body',
                        Icon(CupertinoIcons.text_quote),
                        notificationBodyController,
                        TextInputType.multiline,
                        5,
                        true),
                    MultilineRow().getMultilineRow(
                        'Attachment',
                        'Add an attachment',
                        Icon(CupertinoIcons.paperclip),
                        notificationAttachmentController,
                        TextInputType.multiline,
                        1,
                        false),
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
                              });
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(15),
                            child: MyFonts()
                                .heading1('Send notification', MyColors.white),
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
