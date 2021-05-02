import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/patientmonitor/patientmedications/timingsNotes.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'medicineGlobals.dart' as globals;

class AddMedicine extends StatefulWidget {
  static String id = 'add-medicine';
  final String patientUID;

  AddMedicine({@required this.patientUID});

  @override
  _AddMedicineState createState() => _AddMedicineState(patientUID: patientUID);
}

class _AddMedicineState extends State<AddMedicine> {
  final String patientUID;

  _AddMedicineState({@required this.patientUID});

  TextEditingController medicineNameController = new TextEditingController();
  TextEditingController lastDateController = new TextEditingController();
  final FocusNode medicineFocusNode = FocusNode();

  List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  Widget _getMedicineDetails(
      String heading,
      String placeholder,
      Icon icon,
      TextEditingController controller,
      TextInputType textInputType,
      int lines,
      bool toggleEnabled,
      FocusNode focusNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MyFonts().heading2(heading, MyColors.gray),
        ),
        InkWell(
          onTap: () {
            if (heading == 'End Date') {
              medicineFocusNode.unfocus();
              _selectDate(context, controller);
            } else
              print(false);
          },
          child: CupertinoTextField(
            enabled: toggleEnabled,
            expands: false,
            padding: EdgeInsets.all(15),
            maxLines: lines,
            placeholder: placeholder,
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            prefix: Padding(padding: const EdgeInsets.all(10), child: icon),
            style: TextStyle(
                fontFamily: 'poppins-semi',
                fontSize: 15,
                color: (toggleEnabled) ? MyColors.black : MyColors.gray),
            controller: controller,
            keyboardType: textInputType,
            focusNode: focusNode,
          ),
        ),
      ],
    );
  }

  // Open a mini calendar to make the user select the date:
  Future<Null> _selectDate(
      BuildContext context, TextEditingController textEditingController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
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
        initialDate: (textEditingController.text == '')
            ? DateTime.now()
            : DateTime.parse(
                textEditingController.text.split('-').reversed.join('-') +
                    " 00:00:00"));
    if (picked != null) {
      setState(() {
        textEditingController.text =
            picked.toString().split(' ')[0].split('-').reversed.join('-');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: Consumer<LoginStore>(builder: (_, loginStore, __) {
        var doctorUID = loginStore.firebaseUser.uid;
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                FourthBackground(),
                Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      left: 15,
                      right: 15,
                    ),
                    child: MyFonts().title1('Add a medicine', MyColors.white)),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: 15,
                    right: 15,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getMedicineDetails(
                            'Medicine Name',
                            'Eg. Paracetamol',
                            Icon(Icons.sanitizer_rounded),
                            medicineNameController,
                            TextInputType.text,
                            1,
                            true,
                            medicineFocusNode),
                        _getMedicineDetails(
                            'End Date',
                            'dd-mm-yyyy',
                            Icon(EvaIcons.calendar),
                            lastDateController,
                            TextInputType.datetime,
                            1,
                            false,
                            null),
                        MySpaces.vGapInBetween,
                        MyFonts().heading2('Timings and Notes', MyColors.gray),
                        Divider(color: Colors.black),
                        for (int i = 0; i < 7; i++)
                          Column(
                            children: [
                              TimingsAndNotes(
                                day: day[i],
                                focusNode: medicineFocusNode,
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                padding: EdgeInsets.all(15),
                                color: MyColors.blueLighter,
                                onPressed: () {
                                  List<List<Map>> temp = [
                                    [],
                                    [],
                                    [],
                                    [],
                                    [],
                                    [],
                                    []
                                  ];
                                  Function deepEq =
                                      const DeepCollectionEquality().equals;
                                  if (deepEq(
                                      globals.timingsAndNotesArray, temp)) {
                                    final noTimingEntrySnackBar = SnackBar(
                                        backgroundColor: MyColors.black,
                                        content: MyFonts().body(
                                            'Please add at least 1 timing entry',
                                            MyColors.white));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(noTimingEntrySnackBar);
                                  } else {
                                    FirebaseFirestore firestoreInstance =
                                        FirebaseFirestore.instance;
                                    firestoreInstance
                                        .collection('Medicines')
                                        .doc()
                                        .set({
                                      'medicineScheduled': false,
                                      'PatientUID': patientUID,
                                      'DoctorUID': doctorUID,
                                      'Name': medicineNameController.text,
                                      'End Date': lastDateController.text,
                                      'Monday': globals.timingsAndNotesArray[0],
                                      'Tuesday':
                                          globals.timingsAndNotesArray[1],
                                      'Wednesday':
                                          globals.timingsAndNotesArray[2],
                                      'Thursday':
                                          globals.timingsAndNotesArray[3],
                                      'Friday': globals.timingsAndNotesArray[4],
                                      'Saturday':
                                          globals.timingsAndNotesArray[5],
                                      'Sunday': globals.timingsAndNotesArray[6]
                                    });
                                    globals.timingsAndNotesArray = temp;
                                    Navigator.pop(context);
                                  }
                                },
                                child: MyFonts()
                                    .heading2('Add medicine', MyColors.white),
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
            ),
          ),
        );
      }),
    );
  }
}
