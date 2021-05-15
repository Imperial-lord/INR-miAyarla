import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/dbmanagement/additionalPatientCollections.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/patients/patientManagement.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class PatientSelectDoctor extends StatefulWidget {
  static String id = 'select-doctor';

  @override
  _PatientSelectDoctorState createState() => _PatientSelectDoctorState();
}

List<Color> bodyColor = List.filled(50, MyColors.white);
List<Color> contentColor = List.filled(50, MyColors.gray);

class _PatientSelectDoctorState extends State<PatientSelectDoctor> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
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
                  child: MyFonts().title1(MyStrings().patientSelectDoctorTitle, MyColors.white),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.17,
                    left: 15,
                    right: 15,
                  ),
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Doctors')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            List<dynamic> allDoctorsInfo = [];
                            List<dynamic> allDoctorsUID = [];
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              allDoctorsInfo.add(snapshot.data.docs[i].data());
                              allDoctorsUID.add(snapshot.data.docs[i].id);
                            }
                            return Column(
                              children: [
                                for (int i = 0; i < allDoctorsInfo.length; i++)
                                  // ignore: deprecated_member_use
                                  Column(
                                    children: [
                                      RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (bodyColor[i] ==
                                                MyColors.white) {
                                              bodyColor[i] =
                                                  MyColors.redLighter;
                                              contentColor[i] = MyColors.white;
                                              // make the other button unselected!
                                              for (int j = 0; j < 50; j++) {
                                                if (j != i) {
                                                  bodyColor[j] = MyColors.white;
                                                  contentColor[j] =
                                                      MyColors.gray;
                                                }
                                              }
                                            } else {
                                              bodyColor[i] = MyColors.white;
                                              contentColor[i] = MyColors.gray;
                                            }
                                          });
                                        },
                                        padding: EdgeInsets.all(20),
                                        color: bodyColor[i],
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  allDoctorsInfo[i]['Photo']),
                                              radius: 50,
                                            ),
                                            MySpaces.hLargeGapInBetween,
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MyFonts().heading2(
                                                      allDoctorsInfo[i]['Name'],
                                                      contentColor[i]),
                                                  MySpaces
                                                      .vSmallestGapInBetween,
                                                  MyFonts().body(
                                                      allDoctorsInfo[i]
                                                          ['Specialisation'],
                                                      contentColor[i]),
                                                  MyFonts().body(
                                                      allDoctorsInfo[i]
                                                          ['HospitalName'],
                                                      contentColor[i]),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      MySpaces.vGapInBetween,
                                    ],
                                  ),
                                MySpaces.vGapInBetween,
                                Row(
                                  children: [
                                    Expanded(
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        onPressed: () {
                                          bool flag = false;
                                          var doctorUID;
                                          for (int j = 0; j < 50; j++) {
                                            if (bodyColor[j] ==
                                                MyColors.redLighter) {
                                              doctorUID = allDoctorsUID[j];
                                              flag = true;
                                            }
                                          }
                                          if (!flag) {
                                            final noDoctorSelectedSnackBar =
                                                SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        MyColors.black,
                                                    content: MyFonts().body(
                                                        MyStrings().patientSelectDoctorNoDoctorSelected,
                                                        MyColors.white));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                    noDoctorSelectedSnackBar);
                                          } else {
                                            FirebaseFirestore
                                                firestoreInstance =
                                                FirebaseFirestore.instance;
                                            firestoreInstance
                                                .collection('Assigned Doctor')
                                                .doc(uid)
                                                .set({'DoctorUID': doctorUID});
                                            AdditionalPatientCollections()
                                                .createAdditionalCollections(
                                                    uid);
                                            FirebaseFirestore patientInstance =
                                                FirebaseFirestore.instance;
                                            patientInstance
                                                .collection('Patients')
                                                .doc(uid)
                                                .update(
                                                    {'DoctorUID': doctorUID});
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                PatientManagement.id,
                                                (route) => false);
                                          }
                                        },
                                        padding: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .checkmark_seal_fill,
                                              color: MyColors.white,
                                            ),
                                            MySpaces.hGapInBetween,
                                            MyFonts().heading1(MyStrings().patientSelectDoctorButton,
                                                MyColors.white),
                                          ],
                                        ),
                                        color: MyColors.redLighter,
                                      ),
                                    ),
                                  ],
                                ),
                                MySpaces.vLargeGapInBetween,
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
      },
    );
  }
}
