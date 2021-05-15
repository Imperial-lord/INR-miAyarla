import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/globals/myStrings.dart';
import 'package:health_bag/widgets/backgrounds/secondBackground.dart';
import 'package:health_bag/widgets/backgrounds/thirdBackground.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:health_bag/stores/login_store.dart';
import 'package:health_bag/widgets/loaderHud.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 50,
        width: 40,
        decoration: BoxDecoration(
            color: MyColors.backgroundColor,
            border: Border.all(color: MyColors.blue),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(
              fontFamily: 'poppins-semi', fontSize: 20, color: MyColors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 50,
        width: 40,
        decoration: BoxDecoration(
            color: MyColors.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isOtpLoading,
            child: Scaffold(
                key: loginStore.otpScaffoldKey,
                body: SafeArea(
                  child: Stack(
                    children: [
                      ThirdBackground(),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: MediaQuery.of(context).size.height * 0.12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  MyFonts().largeTitle(MyStrings().otpPageEnter, MyColors.black),
                                  MyFonts()
                                      .largeTitle(MyStrings().otpPageOTP, MyColors.blueLighter),
                                ],
                              ),
                              MyFonts().heading2(
                                  MyStrings().otpPageEnter6DigitCode,
                                  MyColors.gray),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    MyFonts().body(
                                        MyStrings().otpPageResendOTP,
                                        MyColors.blue),
                                    MySpaces.hSmallestGapInBetween,
                                    Icon(EvaIcons.refresh, color: MyColors.blue, size: 15,)
                                  ],
                                ),
                              ),
                              MySpaces.vMediumGapInBetween,
                              Row(
                                children: <Widget>[
                                  otpNumberWidget(0),
                                  Spacer(),
                                  otpNumberWidget(1),
                                  Spacer(),
                                  otpNumberWidget(2),
                                  Spacer(),
                                  otpNumberWidget(3),
                                  Spacer(),
                                  otpNumberWidget(4),
                                  Spacer(),
                                  otpNumberWidget(5),
                                ],
                              ),
                              MySpaces.vMediumGapInBetween,
                              Row(
                                children: [
                                  Expanded(
                                    child: RaisedButton(
                                      onPressed: () {
                                        loginStore.validateOtpAndLogin(
                                            context, text);
                                      },
                                      padding: EdgeInsets.all(15),
                                      child: MyFonts()
                                          .heading1(MyStrings().otpPageConfirm, MyColors.white),
                                      color: MyColors.blueLighter,
                                    ),
                                  ),
                                ],
                              ),
                              NumericKeyboard(
                                onKeyboardTap: _onKeyboardTap,
                                textColor: MyColors.black,
                                rightIcon: Icon(
                                  EvaIcons.backspace,
                                  color: MyColors.red,
                                  size: 30,
                                ),
                                rightButtonFn: () {
                                  setState(() {
                                    text = text.substring(0, text.length - 1);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ),
        );
      },
    );
  }
}
