import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:health_bag/functions/validations/formValidation.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class AddMoreDoctors extends StatefulWidget {
  static String id = 'add-more-doctors';

  @override
  _AddMoreDoctorsState createState() => _AddMoreDoctorsState();
}

Future<QuerySnapshot> getData() async {
  return await FirebaseFirestore.instance.collection('Doctors Database').get();
}

String countryCode = '+91';

class _AddMoreDoctorsState extends State<AddMoreDoctors> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  List<String> _data = [];

  QuerySnapshot data;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      for (int i = 0; i < data.docs.length; i++) {
        String val = data.docs[i].data()['phoneNumber'];
        if (!_data.contains(val))
          _data.add(val.substring(0, 3) +
              '-' +
              val.substring(
                3,
              ));
      }
      return Consumer<LoginStore>(
        builder: (_, loginStore, __) {
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
                    child: MyFonts().title1(MyStrings().addMoreDoctorsTitle, MyColors.white),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                      left: 10,
                      right: 10,
                    ),
                    child: AnimatedList(
                      padding: EdgeInsets.only(bottom: 75),
                      key: _listKey,
                      initialItemCount: _data.length,
                      itemBuilder: (context, index, animation) {
                        return _buildItem(_data[index], animation, index);
                      },
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyColors.red,
              onPressed: () {
                // _onButtonPress();
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _addDocPopup(),
                );
              },
              child: Icon(
                EvaIcons.plus,
                size: 30,
                color: MyColors.white,
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Consumer<LoginStore>(builder: (_, loginStore, __) {
        String doctorUID = loginStore.firebaseUser.uid;
        return Card(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Doctors').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  String name = '';
                  String photo = '';
                  bool allowDelete = false;
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    if (snapshot.data.docs[i].data()['PhoneNumber'] == item) {
                      name = snapshot.data.docs[i].data()['Name'];
                      photo = snapshot.data.docs[i].data()['Photo'];
                      if (doctorUID == snapshot.data.docs[i].id)
                        allowDelete = true;
                    }
                  }
                  return ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    leading: ClipOval(
                      child: Image(
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        image: photo == ''
                            ? AssetImage('assets/icons/doctor.png')
                            : NetworkImage(photo),
                      ),
                    ),
                    title: MyFonts().heading1(item, MyColors.black),
                    subtitle: MyFonts().heading2(
                        name != '' ? name : MyStrings().addMoreDoctorsNotRegistered,
                        MyColors.gray),
                    trailing: (allowDelete == true)
                        ? IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              // pass index to remove an item
                              print('remove');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _removeDocPopup(item, index),
                              );
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              size: 30,
                              color: MyColors.red,
                            ))
                        : null,
                  );
                }
              }),
        );
      }),
    );
  }

  Widget _getRowAddDoctor(TextEditingController controller) {
    countryCode = '+91';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MyFonts().heading2(MyStrings().addMoreDoctorsPhoneNumber, MyColors.gray),
        ),
        Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 103),
              child: CountryCodePicker(
                onChanged: (e) {
                  print(e.toLongString());
                  countryCode = e.toLongString();
                  print(countryCode.split(' ')[0]);
                },
                searchDecoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.backgroundColor,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.blueLighter),
                      borderRadius: BorderRadius.circular(7)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyColors.gray),
                      borderRadius: BorderRadius.circular(7)),
                  hintText: MyStrings().addMoreDoctorsSearchCountry,
                  hintStyle: TextStyle(
                      fontFamily: 'poppins-semi',
                      fontSize: 15,
                      color: MyColors.gray),
                ),
                searchStyle: const TextStyle(
                    fontFamily: 'poppins-semi',
                    fontSize: 15,
                    color: MyColors.black),
                textStyle: const TextStyle(
                    fontFamily: 'poppins-semi',
                    fontSize: 17,
                    color: MyColors.gray),
                dialogTextStyle: const TextStyle(
                    fontFamily: 'poppins-semi',
                    fontSize: 15,
                    color: MyColors.black),
                dialogBackgroundColor: MyColors.backgroundColor,
                initialSelection: 'IN',
                showDropDownButton: true,
                showFlag: false,
                showFlagDialog: true,
                favorite: ['+91', 'IN'],
                boxDecoration: BoxDecoration(
                  color: MyColors.backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CupertinoTextField(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                maxLines: 1,
                placeholder: MyStrings().addMoreDoctorsNumberPlaceholder,
                decoration: BoxDecoration(
                    color: MyColors.backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                style: TextStyle(
                    fontFamily: 'poppins-semi',
                    fontSize: 17,
                    color: MyColors.black),
                controller: controller,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _addDocPopup() {
    TextEditingController phoneNumberController = TextEditingController();
    return Dialog(
      backgroundColor: MyColors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyFonts().heading1(MyStrings().addMoreDoctorsAddADoc, MyColors.blue),
            MySpaces.vGapInBetween,
            _getRowAddDoctor(phoneNumberController),
            MySpaces.vMediumGapInBetween,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String number =
                        countryCode.split(' ')[0] + phoneNumberController.text;
                    if (FormValidation().phoneNumberValidation(number)) {
                      _insertSingleItem(number);
                      Navigator.pop(context);
                    } else {
                      final incorrectNumberSnackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: MyColors.black,
                          content: MyFonts().body(
                              MyStrings().addMoreDoctorsInvalidNumber,
                              MyColors.white));
                      ScaffoldMessenger.of(context)
                          .showSnackBar(incorrectNumberSnackBar);
                    }
                  },
                  child: MyFonts().heading2(MyStrings().addDoctorNotesAdd, MyColors.white),
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

  Widget _removeDocPopup(String number, int index) {
    return AlertDialog(
      title: MyFonts().heading1(
          'Are you sure you want to delete $number from the database?',
          MyColors.black),
      content: MyFonts().body(
          MyStrings().addMoreDoctorsDeleteWarningLoseAccess,
          MyColors.gray),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          onPressed: () {
            _removeSingleItems(index);
            Navigator.pop(context);
          },
          child: MyFonts().heading2('Delete', MyColors.blueLighter),
        ),
      ],
    );
  }

  void _insertSingleItem(String number) {
    String item = number.substring(0, 3) +
        '-' +
        number.substring(
          3,
        );
    int insertIndex = _data.length;
    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance
        .collection('Doctors Database')
        .doc()
        .set({'phoneNumber': number});

    _data.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItems(int index) {
    int removeIndex = index;
    String removedItem = _data.removeAt(removeIndex);

    String itemInDB = removedItem.split('-')[0] + removedItem.split('-')[1];

    final firestoreInstance =
        FirebaseFirestore.instance.collection('Doctors Database');
    firestoreInstance
        .where("phoneNumber", isEqualTo: itemInDB)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.delete();
    });

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, removeIndex);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }
}
