import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class PatientNotifications extends StatefulWidget {
  static String id = 'patient-notifications';

  @override
  _PatientNotificationsState createState() => _PatientNotificationsState();
}

class _PatientNotificationsState extends State<PatientNotifications> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      String patientUID = loginStore.firebaseUser.uid;
      FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection('Notification Bubbles')
          .doc(patientUID)
          .set({'bubble': false});
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyFonts().title1('Your notifications', MyColors.white),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 15,
                  right: 15,
                ),
                child: SingleChildScrollView(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Notifications')
                          .orderBy('TimeOfCreation', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Container();
                        else {
                          List<Map> notificationData = [];
                          List<String> notificationID = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            if (snapshot.data.docs[i].data()['PatientUID'] ==
                                patientUID) {
                              notificationData
                                  .add(snapshot.data.docs[i].data());
                              notificationID.add(snapshot.data.docs[i].id);
                              if (notificationData.length > 20) break;
                            }
                          }
                          return (notificationData.length == 0)
                              ? MyFonts().body(
                                  'Sorry you have no notifications at the moment!',
                                  MyColors.gray)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    for (int i = 0;
                                        i < notificationData.length;
                                        i++)
                                      Card(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.all(10),
                                          leading: Container(
                                              height: double.infinity,
                                              padding: EdgeInsets.only(left: 5),
                                              child: Icon(
                                                  Icons.notifications_active,
                                                  color: MyColors.redLighter)),
                                          title: MyFonts().heading2(
                                              notificationData[i]['Title'],
                                              MyColors.blueLighter),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyFonts().body(
                                                  (notificationData[i]
                                                              ['Body'] ==
                                                          '')
                                                      ? 'This notification has no body.'
                                                      : notificationData[i]
                                                          ['Body'],
                                                  MyColors.gray),
                                              MySpaces.vSmallestGapInBetween,
                                              MyFonts().caption(
                                                  formatDateTime(DateTime.now()
                                                      .toString()),
                                                  MyColors.gray),
                                            ],
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: MyColors.redLighter,
                                            ),
                                            onPressed: () {
                                              FirebaseFirestore
                                                  firestoreInstance =
                                                  FirebaseFirestore.instance;
                                              firestoreInstance
                                                  .collection('Notifications')
                                                  .doc(notificationID[i])
                                                  .delete();
                                            },
                                          ),
                                        ),
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
