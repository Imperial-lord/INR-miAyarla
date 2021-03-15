import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:health_bag/functions/fuzzySearchListManagement.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/pages/doctor/doctorPatientInterface.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/firstBackground.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:provider/provider.dart';

class DoctorHome extends StatefulWidget {
  static String id = 'doctor-home';

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  TextEditingController searchController = new TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data
  List<String> _data = FuzzySearchListManagement().patientList;

  void _getUpdate(String query) {
    setState(() {
      _data = FuzzySearchListManagement().searchResults(query);
    });
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          leading: ClipOval(
            child: Image(
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/patient.png')),
          ),
          title: MyFonts().heading1(item.split(':')[0], MyColors.black),
          subtitle: MyFonts().heading2(item.split(':')[1], MyColors.gray),
          onTap: (){
            Navigator.pushNamed(context, DoctorPatientInterface.id);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_data == []) {
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
                          child: MyFonts().heading2(
                              'No results found for this search',
                              MyColors.gray),
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
