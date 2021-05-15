import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/common/chat/chat.dart';
import 'package:health_bag/pages/doctor/doctorManagement.dart';
import 'package:health_bag/pages/doctor/doctorSendNotifications.dart';
import 'package:health_bag/pages/doctor/patientmonitor/monitorPatientHealth.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorPatientInterface extends StatefulWidget {
  static String id = 'doctor-patient-interface';
  final String patientNumber;

  DoctorPatientInterface({@required this.patientNumber});

  @override
  _DoctorPatientInterfaceState createState() =>
      _DoctorPatientInterfaceState(patientNumber: patientNumber);
}

Widget _getRow(String key, String val) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyFonts().heading2(key, MyColors.blueLighter),
          MySpaces.hLargeGapInBetween,
          Flexible(
              child: Text(
            val,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'poppins-semi',
              fontSize: 15,
              color: MyColors.gray,
            ),
          )),
        ],
      ),
      Divider(),
    ],
  );
}

Widget _transferAlertPopup(BuildContext context, String patientName,
    String doctorName, String patientUID, String doctorUID) {
  return new AlertDialog(
    title: MyFonts().body(
        // "Are you sure you want to transfer $patientName to $doctorName?",
        '$patientName isimli hastayı $doctorName isimli doktora transfer etmek istediğinize emin misiniz?',
        MyColors.black),
    actions: <Widget>[
      // ignore: deprecated_member_use
      FlatButton(
        onPressed: () {
          FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
          firestoreInstance
              .collection('Patients')
              .doc(patientUID)
              .update({'DoctorUID': doctorUID});
          firestoreInstance
              .collection('Assigned Doctor')
              .doc(patientUID)
              .update({'DoctorUID': doctorUID});
          final patientTransferredSnackBar = SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: MyColors.black,
              content: MyFonts().body(
                  MyStrings().doctorPatientInterfaceSuccessfulTransfer,
                  MyColors.white));
          ScaffoldMessenger.of(context)
              .showSnackBar(patientTransferredSnackBar);
          Navigator.pushNamedAndRemoveUntil(
              context, DoctorManagement.id, (route) => false);
        },
        child: MyFonts().heading2(MyStrings().doctorPatientInterfaceYes, MyColors.blueLighter),
      ),
      // ignore: deprecated_member_use
      FlatButton(
        color: MyColors.backgroundColor,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: MyFonts().heading2(MyStrings().doctorPatientInterfaceNo, MyColors.blueLighter),
      ),
    ],
  );
}

Widget _transferPatientPopup(BuildContext context, String patientUID,
    String doctorUID, String patientName) {
  return AlertDialog(
    titlePadding: EdgeInsets.all(0),
    title: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: MyFonts().title1(
              MyStrings().doctorPatientInterfaceTransferTitle, MyColors.red),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: MyFonts().subHeadline(
              MyStrings().doctorPatientInterfaceTransferWarning, MyColors.gray),
        ),
        Divider(
          color: MyColors.black,
        ),
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Doctors').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                List<String> docUIDs = [];
                List<String> docNames = [];
                List<String> docNumbers = [];
                List<String> docPhotos = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  if (snapshot.data.docs[i].id != doctorUID) {
                    docUIDs.add(snapshot.data.docs[i].id);
                    docNames.add(snapshot.data.docs[i].data()['Name']);
                    docNumbers.add(snapshot.data.docs[i].data()['PhoneNumber']);
                    docPhotos.add(snapshot.data.docs[i].data()['Photo']);
                  }
                }
                return Container(
                  height: 0.4 * MediaQuery.of(context).size.height,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: docUIDs.length,
                      itemBuilder: (context, i) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _transferAlertPopup(context, patientName,
                                          docNames[i], patientUID, docUIDs[i]),
                                );
                              },
                              child: ListTile(
                                leading: ClipOval(
                                  child: Image(
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(docPhotos[i])),
                                ),
                                title: MyFonts()
                                    .heading2(docNumbers[i], MyColors.black),
                                subtitle:
                                    MyFonts().body(docNames[i], MyColors.gray),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: MyColors.white, elevation: 0),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
            }),
      ],
    ),
    actions: [
      // ignore: deprecated_member_use
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: MyFonts().heading2(
            MyStrings().doctorPatientInterfaceBack, MyColors.blueLighter),
      ),
    ],
  );
}

class _DoctorPatientInterfaceState extends State<DoctorPatientInterface> {
  final String patientNumber;

  _DoctorPatientInterfaceState({@required this.patientNumber});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var doctorUid = loginStore.firebaseUser.uid;
      return Scaffold(
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Patients')
                  .where('PhoneNumber', isEqualTo: patientNumber)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else {
                  var userData = snapshot.data.docs[0].data();
                  var patientUID = snapshot.data.docs[0].id;
                  String title = userData['Name'].split(' ')[0];
                  return Stack(
                    children: [
                      FourthBackground(),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                          left: 20,
                          right: 20,
                        ),
                        child: MyFonts()
                            .title1(
                            // "$title's Profile",
                            "$title's Profili",
                            MyColors.white),
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
                              MySpaces.vSmallGapInBetween,
                              Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData['Photo']),
                                  radius: 60,
                                ),
                              ),
                              MySpaces.vSmallestGapInBetween,
                              Center(
                                  child: MyFonts().heading1(
                                      '${userData['Name']}', MyColors.black)),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('Doctor Chat Bubbles')
                                          .doc(patientUID)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Container();
                                        else {
                                          bool isUnread =
                                              snapshot.data.data()['bubble'];
                                          return Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Chat(
                                                                peerName:
                                                                    userData[
                                                                        'Name'],
                                                                id: doctorUid,
                                                                peerId:
                                                                    patientUID,
                                                                peerAvatar:
                                                                    userData[
                                                                        'Photo'],
                                                                sharedMessage:
                                                                    null,
                                                              )));
                                                },
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons
                                                          .paperplane_fill,
                                                      color: MyColors.white,
                                                    ),
                                                    MySpaces.hGapInBetween,
                                                    MyFonts().heading2(
                                                        MyStrings()
                                                            .doctorPatientInterfaceChat,
                                                        MyColors.white),
                                                  ],
                                                ),
                                                color: MyColors.blueLighter,
                                              ),
                                              Visibility(
                                                visible: isUnread,
                                                child: Positioned(
                                                  top: -5,
                                                  right: -5,
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    color: MyColors.redLighter,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      }),
                                  Spacer(),
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DoctorSendNotifications(
                                                      patientUID: patientUID)));
                                    },
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.bell_solid,
                                          color: MyColors.white,
                                        ),
                                        MySpaces.hGapInBetween,
                                        MyFonts().heading2(
                                            MyStrings()
                                                .doctorPatientInterfaceSendNotification,
                                            MyColors.white),
                                      ],
                                    ),
                                    color: MyColors.redLighter,
                                  ),
                                ],
                              ),
                              MySpaces.vSmallGapInBetween,
                              MyFonts().heading1(MyStrings().doctorPatientInterfacePersonal, MyColors.black),
                              MySpaces.vGapInBetween,
                              _getRow(MyStrings().doctorPatientInterfaceDOB, formatDateTime(userData['DOB'])),
                              _getRow(MyStrings().doctorPatientInterfaceAge, userData['Age']),
                              _getRow(MyStrings().doctorPatientInterfaceGender, userData['Gender']),
                              _getRow(MyStrings().doctorPatientInterfacePhoneNumber, userData['PhoneNumber']),
                              _getRow(
                                  MyStrings().doctorPatientInterfaceEmailAddress, userData['EmailAddress']),
                              _getRow(
                                  MyStrings().doctorPatientInterfaceResidentialAddress, userData['Address']),
                              _getRow(MyStrings().doctorPatientInterfaceSignUpDate,
                                  formatDateTime(userData['SignUpDate'])),
                              MySpaces.vSmallGapInBetween,
                              MyFonts()
                                  .heading1(MyStrings().doctorPatientInterfaceMedicalHistory, MyColors.black),
                              MySpaces.vGapInBetween,
                              _getRow(
                                  MyStrings().doctorPatientInterfaceIllness,
                                  userData['Illness'] == ''
                                      ? MyStrings().doctorPatientInterfaceNoDataAvailable
                                      : userData['Illness']),
                              _getRow(
                                  MyStrings().doctorPatientInterfaceAllergies,
                                  userData['Allergies'] == ''
                                      ? MyStrings().doctorPatientInterfaceNoDataAvailable
                                      : userData['Allergies']),
                              _getRow(
                                  MyStrings().doctorPatientInterfaceGeneticDiseases,
                                  userData['GeneticDiseases'] == ''
                                      ? MyStrings().doctorPatientInterfaceNoDataAvailable
                                      : userData['GeneticDiseases']),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MonitorPatientHealth(
                                                          patientUID:
                                                              patientUID,
                                                        )));
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            EvaIcons.activityOutline,
                                            color: MyColors.blueLighter,
                                          ),
                                          MySpaces.hGapInBetween,
                                          MyFonts().heading2(
                                              MyStrings().doctorPatientInterfaceMonitorPatientHealth,
                                              MyColors.blueLighter),
                                        ],
                                      ),
                                      color: MyColors.white,
                                    ),
                                  ),
                                ],
                              ),
                              MySpaces.vSmallGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _transferPatientPopup(
                                                  context,
                                                  patientUID,
                                                  doctorUid,
                                                  userData['Name']),
                                        );
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            CupertinoIcons
                                                .arrowshape_turn_up_right_fill,
                                            color: MyColors.white,
                                          ),
                                          MySpaces.hGapInBetween,
                                          MyFonts().heading2(MyStrings().doctorPatientInterfaceTransferTitle,
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
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ),
      );
    });
  }
}
