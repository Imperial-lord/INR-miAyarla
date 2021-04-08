import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/getDayFromWeek.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/patientmonitor/patientmedications/medicineGlobals.dart'
    as globals;

class PatientTimingsNotes extends StatefulWidget {
  static String id = 'patient-timings-and-notes';

  final String day;

  PatientTimingsNotes({@required this.day});

  @override
  _PatientTimingsNotesState createState() =>
      _PatientTimingsNotesState(day: day);
}

class _PatientTimingsNotesState extends State<PatientTimingsNotes> {
  final String day;

  _PatientTimingsNotesState({@required this.day});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Widget _buildItem(Map item, Animation animation, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: ListTile(
          tileColor: MyColors.white,
          title: Row(
            children: [
              MyFonts().body('Time: ${item['Time']}', MyColors.black),
              Spacer(),
              MyFonts().body('Dosage: ${item['Dosage']}', MyColors.black),
            ],
          ),
          subtitle:
              MyFonts().subHeadline('Notes: ${item['Notes']}', MyColors.gray),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyFonts().heading1(day, MyColors.blue),
          MySpaces.vGapInBetween,
          (globals.timingsAndNotesArray[getDayFromWeek(day)].length == 0)
              ? MyFonts().body('No medicines for this day', MyColors.gray)
              : AnimatedList(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  key: _listKey,
                  initialItemCount:
                      globals.timingsAndNotesArray[getDayFromWeek(day)].length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(
                        globals.timingsAndNotesArray[getDayFromWeek(day)]
                            [index],
                        animation,
                        index);
                  },
                ),
          MySpaces.vGapInBetween,
        ],
      ),
    );
  }
}
