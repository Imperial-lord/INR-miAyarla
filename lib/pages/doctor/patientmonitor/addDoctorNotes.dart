import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';

class AddDoctorNotes extends StatefulWidget {
  static String id = 'add-doc-notes';

  @override
  _AddDoctorNotesState createState() => _AddDoctorNotesState();
}

class _AddDoctorNotesState extends State<AddDoctorNotes> {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  List<String> _dataDocNotes = [
    'Take medicines on time',
    'Remember to exercise daily'
  ];

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          ListTile(
            tileColor: MyColors.white,
            dense: true,
            title: MyFonts().heading2(item, MyColors.blueLighter),
            trailing: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  // pass index to remove an item
                  print('remove');
                  _removeSingleItems(index);
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: MyColors.red,
                )),
          ),
          Divider(),
        ],
      ),
    );
  }

  void _removeSingleItems(int index) {
    int removeIndex = index;
    String removedItem = _dataDocNotes.removeAt(removeIndex);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, removeIndex);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }

  void _insertSingleItem(String item) {
    int insertIndex = _dataDocNotes.length;
    _dataDocNotes.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

  Widget _addDocNotePopup() {
    TextEditingController doctorNoteController = TextEditingController();
    return Dialog(
      backgroundColor: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyFonts().heading1('Add a doctor', MyColors.blue),
            MySpaces.vGapInBetween,
            CupertinoTextField(
              padding: EdgeInsets.all(10),
              expands: true,
              maxLines: null,
              minLines: null,
              placeholder: "Enter a note",
              decoration: BoxDecoration(
                  color: MyColors.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              style: TextStyle(
                  fontFamily: 'poppins-semi',
                  fontSize: 17,
                  color: MyColors.black),
              controller: doctorNoteController,
              keyboardType: TextInputType.text,
            ),
            MySpaces.vMediumGapInBetween,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(doctorNoteController.text=='')
                    {
                      Navigator.pop(context);
                      final emptyNoteSnackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: MyColors.black,
                          content: MyFonts().body(
                              "Can't add a blank note",
                              MyColors.white));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(emptyNoteSnackBar);
                    }
                    else {
                      _insertSingleItem(doctorNoteController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: MyFonts().heading2('Add', MyColors.white),
                  style: ElevatedButton.styleFrom(
                      primary: MyColors.blueLighter,
                      padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MySpaces.vGapInBetween,
        Row(
          children: [
            MyFonts().heading1('Doctor Notes', MyColors.black),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _addDocNotePopup(),
                );
              },
              child: MyFonts()
                  .subHeadline('Add a note'.toUpperCase(), MyColors.white),
              style: ElevatedButton.styleFrom(primary: MyColors.blueLighter),
            ),
          ],
        ),
        MySpaces.vGapInBetween,
        AnimatedList(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          key: _listKey,
          initialItemCount: _dataDocNotes.length,
          itemBuilder: (context, index, animation) {
            return _buildItem(_dataDocNotes[index], animation, index);
          },
        ),
      ]),
    );
  }
}
