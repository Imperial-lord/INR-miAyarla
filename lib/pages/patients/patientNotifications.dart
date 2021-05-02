import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Container();
                        else {
                          List<Map> notificationData = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++)
                            if (snapshot.data.docs[i].data()['PatientUID'] ==
                                patientUID)
                              notificationData
                                  .add(snapshot.data.docs[i].data());
                          return (notificationData.length==0)?MyFonts().body(
                              'Sorry you have no notifications at the moment!',
                              MyColors.gray):
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (int i = 0; i < notificationData.length; i++)
                                Card(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    leading: Container(
                                        height: double.infinity,
                                        child: Icon(Icons.notifications_active,
                                            color: MyColors.redLighter)),
                                    title: MyFonts().heading2(
                                        notificationData[i]['Title'],
                                        MyColors.blueLighter),
                                    subtitle: MyFonts().body(
                                        notificationData[i]['Body'],
                                        MyColors.gray),
                                    trailing: Icon(CupertinoIcons.wrench_fill),
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
