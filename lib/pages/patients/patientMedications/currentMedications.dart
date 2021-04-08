import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/patientmonitor/patientmedications/editMedicine.dart';
import 'package:health_bag/pages/doctor/patientmonitor/patientmedications/medicineGlobals.dart' as globals;
import 'package:health_bag/pages/patients/patientMedications/viewMedicine.dart';

class CurrentMedications extends StatefulWidget {
  static String id = 'current-medications';
  final String patientUID;

  CurrentMedications({@required this.patientUID});

  @override
  _CurrentMedicationsState createState() => _CurrentMedicationsState(patientUID: patientUID);
}

class _CurrentMedicationsState extends State<CurrentMedications> {
  final String patientUID;

  _CurrentMedicationsState({@required this.patientUID});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MySpaces.vGapInBetween,
        MyFonts().heading1('Current Medications', MyColors.black),
        MySpaces.vGapInBetween,
        StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('Medicines').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container();
              else {
                List<Map> medicineData = [];
                List<String> medicineID= [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  if (snapshot.data.docs[i].data()['PatientUID'] == patientUID) {
                    medicineData.add(snapshot.data.docs[i].data());
                    medicineID.add(snapshot.data.docs[i].id);
                  }
                }
                return Column(
                  children: [
                    for (int i = 0; i < medicineData.length; i++)
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              globals.timingsAndNotesArray[0]=List.from(medicineData[i]['Monday']);
                              globals.timingsAndNotesArray[1]=List.from(medicineData[i]['Tuesday']);
                              globals.timingsAndNotesArray[2]=List.from(medicineData[i]['Wednesday']);
                              globals.timingsAndNotesArray[3]=List.from(medicineData[i]['Thursday']);
                              globals.timingsAndNotesArray[4]=List.from(medicineData[i]['Friday']);
                              globals.timingsAndNotesArray[5]=List.from(medicineData[i]['Saturday']);
                              globals.timingsAndNotesArray[6]=List.from(medicineData[i]['Sunday']);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                                  ViewMedicine(medicineData: medicineData[i], medicineID: medicineID[i],)));
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              tileColor: MyColors.white,
                              leading: Image(
                                  image: AssetImage('assets/icons/pills.png')),
                              title: MyFonts().heading2(
                                  medicineData[i]['Name'], MyColors.black),
                              subtitle: MyFonts().body(
                                  'Ending Date: ${medicineData[i]['End Date']}',
                                  MyColors.gray),
                            ),
                          ),
                          MySpaces.vGapInBetween,
                        ],
                      ),
                  ],
                );
              }
            }),
      ]),
    );
  }
}
