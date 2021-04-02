import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:health_bag/functions/search/fuzzySearchListManagement.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/pages/doctor/doctorPatientInterface.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorHome extends StatefulWidget {
  static String id = 'doctor-home';

  final String doctorUID;

  DoctorHome({@required this.doctorUID});

  @override
  _DoctorHomeState createState() => _DoctorHomeState(doctorUID: doctorUID);
}

Future<QuerySnapshot> getData() async {
  return await FirebaseFirestore.instance.collection('Patients').get();
}

class _DoctorHomeState extends State<DoctorHome> {
  final String doctorUID;

  _DoctorHomeState({@required this.doctorUID});

  TextEditingController searchController = new TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  List<dynamic> _patientList, _patientListStatic;
  List<String> _data;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      List<dynamic> docList = [];
      for (int i = 0; i < value.docs.length; i++) {
        var documentData = value.docs[i].data();
        if (documentData['DoctorUID'] == doctorUID) {
          docList.add(documentData);
        }
      }
      setState(() {
        _patientList = docList;
        _patientListStatic = docList;
        _data = FuzzySearchListManagement(patientList: _patientListStatic)
            .convertDynamicToString(_patientList);
      });
    });
  }

  void _getUpdate(String query) {
    setState(() {
      _patientList = FuzzySearchListManagement(patientList: _patientListStatic)
          .searchResults(query);
      _data = FuzzySearchListManagement(patientList: _patientListStatic)
          .convertDynamicToString(_patientList);
    });
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Patients')
            .where('PhoneNumber', isEqualTo: _patientList[index]['PhoneNumber'])
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container();
          else {
            var patientUID = snapshot.data.docs[0].id;
            return SizeTransition(
              sizeFactor: animation,
              child: Card(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Doctor Chat Bubbles')
                        .doc(patientUID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container();
                      else {
                        bool isUnread = snapshot.data.data()['bubble'];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          leading: ClipOval(
                            child: Image(
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(_patientList[index]['Photo'])),
                          ),
                          title: MyFonts()
                              .heading1(item.split(':')[0], MyColors.black),
                          subtitle: MyFonts()
                              .heading2(item.split(':')[1], MyColors.gray),
                          trailing: Visibility(
                            visible: isUnread,
                            child: Icon(
                              Icons.brightness_1,
                              color: MyColors.redLighter,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DoctorPatientInterface(
                                            patientNumber: _patientList[index]
                                                ['PhoneNumber'])));
                          },
                        );
                      }
                    }),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Consumer<LoginStore>(builder: (_, loginStore, __) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                FourthBackground(),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: 20,
                    right: 20,
                  ),
                  child: MyFonts().title1('Your Patients', MyColors.white),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: 10,
                    right: 10,
                  ),
                  child: Card(
                    elevation: 2,
                    child: CupertinoTextField(
                      padding: EdgeInsets.all(15),
                      maxLines: 1,
                      placeholder: 'Search a name or number',
                      decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      prefix: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            CupertinoIcons.search,
                            color: MyColors.gray,
                          )),
                      style: TextStyle(
                          fontFamily: 'poppins-semi',
                          fontSize: 17,
                          color: MyColors.black),
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        _getUpdate(value);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: 10,
                    right: 10,
                  ),
                  child: _data.length == 0
                      ? Center(
                          child: MyFonts()
                              .heading2('No results found', MyColors.gray),
                        )
                      : AnimatedList(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          key: _listKey,
                          initialItemCount: _data.length,
                          itemBuilder: (context, index, animation) {
                            if (index < _data.length)
                              return _buildItem(_data[index], animation, index);
                            else
                              return Container();
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }
}
