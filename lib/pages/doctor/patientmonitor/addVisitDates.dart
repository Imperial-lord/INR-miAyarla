import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';

class AddVisitDates extends StatefulWidget {
  static String id = 'add-visit-dates';

  @override
  _AddVisitDatesState createState() => _AddVisitDatesState();
}

Widget _getRowDoctorAddVisitDates(String heading, String placeholder,
    TextEditingController controller, bool toggleEnabled) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MyFonts().heading2(heading, MyColors.gray),
      ),
      CupertinoTextField(
        enabled: toggleEnabled,
        expands: false,
        padding: EdgeInsets.all(15),
        maxLines: 1,
        placeholder: placeholder,
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        prefix: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(EvaIcons.calendar,
                color: (toggleEnabled) ? MyColors.black : MyColors.gray)),
        style: TextStyle(
            fontFamily: 'poppins-semi',
            fontSize: 17,
            color: (toggleEnabled) ? MyColors.black : MyColors.gray),
        controller: controller,
        keyboardType: TextInputType.datetime,
      ),
    ],
  );
}

class _AddVisitDatesState extends State<AddVisitDates> {
  TextEditingController lastVisitController = new TextEditingController();
  TextEditingController nextVisitController = new TextEditingController();
  bool toggleEnabled = false;
  String buttonText = 'Edit';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySpaces.vGapInBetween,
          Row(
            children: [
              MyFonts().heading1('Important Dates', MyColors.black),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    toggleEnabled = !toggleEnabled;
                    if (buttonText == 'Edit')
                      buttonText = 'Save';
                    else
                      buttonText = 'Edit';
                  });
                },
                child: MyFonts()
                    .subHeadline(buttonText.toUpperCase(), MyColors.white),
                style: ElevatedButton.styleFrom(primary: MyColors.blueLighter),
              ),
            ],
          ),
          _getRowDoctorAddVisitDates('Last visit date', 'dd/mm/yyyy',
              lastVisitController, toggleEnabled),
          _getRowDoctorAddVisitDates('Next visit date', 'dd/mm/yyyy',
              nextVisitController, toggleEnabled),
        ],
      ),
    );
  }
}
