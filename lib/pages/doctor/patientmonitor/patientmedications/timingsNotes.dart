import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/functions/general/formatDateTime.dart';
import 'package:health_bag/functions/general/getDayFromWeek.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'medicineGlobals.dart' as globals;

class TimingsAndNotes extends StatefulWidget {
  static String id = 'timings-and-notes';

  final String day;
  final FocusNode focusNode;

  TimingsAndNotes({@required this.day, this.focusNode});

  @override
  _TimingsAndNotesState createState() => _TimingsAndNotesState(day: day, focusNode:focusNode);
}

class _TimingsAndNotesState extends State<TimingsAndNotes> {
  final String day;
  final FocusNode focusNode;
  _TimingsAndNotesState({@required this.day, this.focusNode});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Widget _getMedicineTimingDetails(
      String heading,
      String placeholder,
      Icon icon,
      TextEditingController controller,
      TextInputType textInputType,
      int lines,
      bool toggleEnabled) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(padding: const EdgeInsets.all(10), child: icon),
            MyFonts().heading2(heading, MyColors.gray),
          ],
        ),
        CupertinoTextField(
          enabled: toggleEnabled,
          expands: false,
          padding: EdgeInsets.all(15),
          maxLines: lines,
          placeholder: placeholder,
          decoration: BoxDecoration(
              color: MyColors.backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          style: TextStyle(
              fontFamily: 'poppins-semi',
              fontSize: 15,
              color: (toggleEnabled) ? MyColors.black : MyColors.gray),
          controller: controller,
          keyboardType: textInputType,
        ),
      ],
    );
  }

  Future<Null> _selectTime(BuildContext context, String time,
      TextEditingController controller) async {
    TimeOfDay selectedTime = TimeOfDay(
        hour: int.parse(time.split(':')[0]),
        minute: int.parse(time.split(':')[1]));

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        String hour = selectedTime.hour.toString();
        String minute = selectedTime.minute.toString();
        controller.text = (format24to12HrTime(hour + ':' + minute));
      });
    }
  }

  Widget _getMedicineTimeFromWidget(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(10), child: Icon(Icons.alarm)),
            MyFonts().heading2(MyStrings().timingsAndNotesTime, MyColors.gray),
          ],
        ),
        InkWell(
          onTap: () {
            _selectTime(
                context, format12To24HrTime(controller.text), controller);
          },
          child: CupertinoTextField(
            enabled: false,
            padding: EdgeInsets.all(15),
            placeholder: 'Eg. 10:00 AM',
            decoration: BoxDecoration(
                color: MyColors.backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            style: TextStyle(
                fontFamily: 'poppins-semi',
                fontSize: 15,
                color: MyColors.black),
            controller: controller,
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }

  Widget _medDetailsPopup() {
    TextEditingController medicineTimeController = new TextEditingController();
    TextEditingController medicineNotesController = new TextEditingController();
    TextEditingController medicineDosageController =
        new TextEditingController();
    medicineTimeController.text = '10:00 AM';
    medicineDosageController.text = MyStrings().timingsAndNotesDosageValue;
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(15),
        color: MyColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _getMedicineTimeFromWidget(medicineTimeController),
                ),
                MySpaces.hGapInBetween,
                Expanded(
                  child: _getMedicineTimingDetails(
                      MyStrings().timingsAndNotesDosage,
                      MyStrings().timingsAndNotesDosagePlaceholder,
                      Icon(CupertinoIcons.drop_fill),
                      medicineDosageController,
                      TextInputType.text,
                      1,
                      true),
                ),
              ],
            ),
            _getMedicineTimingDetails(
                MyStrings().timingsAndNotesNotes,
                MyStrings().timingsAndNotesNotesPlaceholder,
                Icon(CupertinoIcons.text_quote),
                medicineNotesController,
                TextInputType.text,
                1,
                true),
            MySpaces.vGapInBetween,
            Row(
              children: [
                Spacer(),
                RaisedButton(
                  color: MyColors.blueLighter,
                  child: MyFonts().body(MyStrings().timingsAndNotesSave, MyColors.white),
                  onPressed: () {
                    Map item = {
                      'Time': medicineTimeController.text,
                      'Dosage': medicineDosageController.text,
                      'Notes': medicineNotesController.text
                    };
                    int insertIndex = globals
                        .timingsAndNotesArray[getDayFromWeek(day)].length;
                    globals.timingsAndNotesArray[getDayFromWeek(day)]
                        .insert(insertIndex, item);
                    _listKey.currentState.insertItem(insertIndex);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
          trailing: IconButton(
              onPressed: () {
                _removeSingleItems(index);
              },
              icon: Icon(
                Icons.delete_rounded,
                color: MyColors.red,
              )),
        ),
      ),
    );
  }

  void _removeSingleItems(int index) {
    int removeIndex = index;
    Map removedItem =
        globals.timingsAndNotesArray[getDayFromWeek(day)].removeAt(removeIndex);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, removeIndex);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }

  void _insertSingleItem() {
    showDialog(
        context: context,
        builder: (BuildContext context) => _medDetailsPopup());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.backgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              MyFonts().heading1(day, MyColors.blue),
              Spacer(),
              // ignore: deprecated_member_use
              RaisedButton(
                  onPressed: () {
                    if(focusNode.hasPrimaryFocus) focusNode.unfocus();
                    _insertSingleItem();
                  },
                  color: MyColors.white,
                  child: Row(
                    children: [
                      Icon(
                        Icons.note_add_rounded,
                        color: MyColors.black,
                        size: 20,
                      ),
                      MySpaces.hSmallestGapInBetween,
                      MyFonts().subHeadline(MyStrings().timingsAndNotesAddAnEntry, MyColors.black)
                    ],
                  )),
            ],
          ),
          MySpaces.vSmallGapInBetween,
          AnimatedList(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            key: _listKey,
            initialItemCount:
                globals.timingsAndNotesArray[getDayFromWeek(day)].length,
            itemBuilder: (context, index, animation) {
              return _buildItem(
                  globals.timingsAndNotesArray[getDayFromWeek(day)][index],
                  animation,
                  index);
            },
          ),
        ],
      ),
    );
  }
}
