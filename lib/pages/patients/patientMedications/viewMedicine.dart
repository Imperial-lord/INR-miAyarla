import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/pages/patients/patientMedications/patientTimingsNotes.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class ViewMedicine extends StatefulWidget {
  static String id = 'view-medicine';
  final Map medicineData;
  final String medicineID;

  ViewMedicine({@required this.medicineData, @required this.medicineID});

  @override
  _ViewMedicineState createState() =>
      _ViewMedicineState(medicineData: medicineData, medicineID: medicineID);
}

class _ViewMedicineState extends State<ViewMedicine> {
  final Map medicineData;
  final String medicineID;

  _ViewMedicineState({@required this.medicineData, @required this.medicineID});

  TextEditingController medicineNameController = new TextEditingController();
  TextEditingController lastDateController = new TextEditingController();

  @override
  initState() {
    super.initState();
    setState(() {
      medicineNameController.text = medicineData['Name'];
      lastDateController.text = medicineData['End Date'];
    });
  }

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
      int lines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MyFonts().heading2(heading, MyColors.gray),
        ),
        CupertinoTextField(
          enabled: false,
          expands: false,
          padding: EdgeInsets.all(15),
          maxLines: lines,
          placeholder: placeholder,
          decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          prefix: Padding(padding: const EdgeInsets.all(10), child: icon),
          style: TextStyle(
              fontFamily: 'poppins-semi', fontSize: 15, color: MyColors.gray),
          controller: controller,
          keyboardType: textInputType,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      var doctorUID = medicineData['DoctorUID'];
      var patientUID = medicineData['PatientUID'];
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
                  child: MyFonts()
                      .title1(MyStrings().viewMedicineTitle, MyColors.white)),
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
                          MyStrings().viewMedicineMedicineName,
                          MyStrings().viewMedicineMedicinePlaceholder,
                          Icon(Icons.sanitizer_rounded),
                          medicineNameController,
                          TextInputType.text,
                          1),
                      _getMedicineDetails(
                          MyStrings().viewMedicineEndDate,
                          'dd-mm-yyyy',
                          Icon(EvaIcons.calendar),
                          lastDateController,
                          TextInputType.datetime,
                          1),
                      MySpaces.vGapInBetween,
                      MyFonts().heading2(MyStrings().viewMedicineTimingsAndNotes, MyColors.gray),
                      Divider(color: Colors.black),
                      for (int i = 0; i < 7; i++)
                        PatientTimingsNotes(day: day[i]),
                      MySpaces.vLargeGapInBetween,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
