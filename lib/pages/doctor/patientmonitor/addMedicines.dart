import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';

class AddMedicines extends StatefulWidget {
  static String id = 'add-medicines';
  final String patientUID;

  AddMedicines({@required this.patientUID});

  @override
  _AddMedicinesState createState() => _AddMedicinesState(patientUID: patientUID);
}

Future<DocumentSnapshot> getData(String uid) async {
  return await FirebaseFirestore.instance
      .collection('Medicines')
      .doc(uid)
      .get();
}

class _AddMedicinesState extends State<AddMedicines> {
  final String patientUID;

  _AddMedicinesState({@required this.patientUID});

  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  List<dynamic> _dataMedicines;

  @override
  initState() {
    super.initState();
    print(patientUID);
    getData(patientUID).then((value) {
      setState(() {
        _dataMedicines = value.data()['Medicine'];
      });
    });
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          ListTile(
            leading: Image(
                image: NetworkImage('https://i.ibb.co/fv0ztpr/medicine.png')),
            tileColor: MyColors.white,
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
    String item = _dataMedicines[index];
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection('Medicines').doc(patientUID).update({
      'Medicine': FieldValue.arrayRemove([item]),
    });
    int removeIndex = index;
    String removedItem = _dataMedicines.removeAt(removeIndex);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, removeIndex);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }

  void _insertSingleItem(String item) {
    int insertIndex = _dataMedicines.length;
    _dataMedicines.insert(insertIndex, item);
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
            MyFonts().heading1('Add a medicine', MyColors.blue),
            MySpaces.vGapInBetween,
            CupertinoTextField(
              padding: EdgeInsets.all(10),
              expands: true,
              maxLines: null,
              minLines: null,
              placeholder: "Enter medicine name",
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
                    if (doctorNoteController.text == '') {
                      Navigator.pop(context);
                      final emptyNoteSnackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: MyColors.black,
                          content: MyFonts().body(
                              "Please enter a medicine name", MyColors.white));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(emptyNoteSnackBar);
                    } else {
                      _insertSingleItem(doctorNoteController.text);
                      FirebaseFirestore firestoreInstance =
                          FirebaseFirestore.instance;
                      firestoreInstance
                          .collection('Medicines')
                          .doc(patientUID)
                          .update({
                        'Medicine':
                        FieldValue.arrayUnion([doctorNoteController.text]),
                      });
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
    if (_dataMedicines == null)
      return Container();
    else
      return Material(
        color: Colors.transparent,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MySpaces.vGapInBetween,
          Row(
            children: [
              MyFonts().heading1('Medications', MyColors.black),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _addDocNotePopup(),
                  );
                },
                child: MyFonts()
                    .subHeadline('Add medicines'.toUpperCase(), MyColors.white),
                style: ElevatedButton.styleFrom(primary: MyColors.blueLighter),
              ),
            ],
          ),
          MySpaces.vGapInBetween,
          AnimatedList(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            key: _listKey,
            initialItemCount: _dataMedicines.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(_dataMedicines[index], animation, index);
            },
          ),
        ]),
      );
  }
}
