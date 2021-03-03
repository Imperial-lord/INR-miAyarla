import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/loader_hud.dart';
import 'package:provider/provider.dart';

String countryCode = '+91';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);
  static String id = 'sign-in';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      return Observer(
        builder: (_) => LoaderHUD(
          inAsyncCall: loginStore.isLoginLoading,
          child: Scaffold(
            key: loginStore.loginScaffoldKey,
            body: SafeArea(
              child: Material(
                child: Stack(
                  children: [
                    SecondBackground(),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: MediaQuery.of(context).size.height * 0.32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyFonts().largeTitle('Sign ', MyColors.black),
                                MyFonts()
                                    .largeTitle('In', MyColors.blueLighter),
                              ],
                            ),
                            MyFonts().heading2(
                                'Enter your mobile number to get an OTP',
                                MyColors.gray),
                            MySpaces.vMediumGapInBetween,
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 120),
                                  child: CountryCodePicker(
                                    onChanged: (e) {
                                      print(e.toLongString());
                                      countryCode = e.toLongString();
                                      print(countryCode.split(' ')[0]);
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    searchDecoration: InputDecoration(
                                      filled: true,
                                      fillColor: MyColors.backgroundColor,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: MyColors.blueLighter),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: MyColors.gray),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      hintText: 'Search Country or Code',
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
                                        fontSize: 20,
                                        color: MyColors.gray),
                                    dialogTextStyle: const TextStyle(
                                        fontFamily: 'poppins-semi',
                                        fontSize: 15,
                                        color: MyColors.black),
                                    dialogBackgroundColor:
                                        MyColors.backgroundColor,
                                    initialSelection: 'IN',
                                    showDropDownButton: true,
                                    showFlag: false,
                                    showFlagDialog: true,
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    favorite: ['+91', 'IN'],
                                    boxDecoration: BoxDecoration(
                                      color: MyColors.backgroundColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: CupertinoTextField(
                                      expands: false,
                                      padding: EdgeInsets.all(15),
                                      maxLines: 1,
                                      placeholder: '10 digit number',
                                      decoration: BoxDecoration(
                                          color: MyColors.backgroundColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      style: TextStyle(
                                          fontFamily: 'poppins-semi',
                                          fontSize: 20,
                                          color: MyColors.black),
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      clearButtonMode:
                                          OverlayVisibilityMode.editing,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            MySpaces.vMediumGapInBetween,
                            Row(
                              children: [
                                Expanded(
                                    child: RaisedButton(
                                  padding: EdgeInsets.all(15),
                                  child: MyFonts()
                                      .heading1('Get OTP', MyColors.white),
                                  onPressed: () {
                                    if (phoneController.text.isNotEmpty) {
                                      print(countryCode.split(' ')[0] +
                                          phoneController.text.toString());
                                      loginStore.getCodeWithPhoneNumber(
                                          context,
                                          countryCode.split(' ')[0] +
                                              phoneController.text.toString());
                                    } else {
                                      loginStore.loginScaffoldKey.currentState
                                          .showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: MyColors.black,
                                            content: MyFonts().body(
                                                'Please enter a phone number',
                                                MyColors.white)),
                                      );
                                    }
                                  },
                                  color: MyColors.blueLighter,
                                )),
                              ],
                            ),
                            MySpaces.vMediumGapInBetween,
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
