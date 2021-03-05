import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/pages/common/auth/signin.dart';
import 'package:health_bag/pages/common/userType.dart';
import 'package:health_bag/pages/common/welcome.dart';
import 'package:mobx/mobx.dart';
import 'package:health_bag/pages/common/home_page.dart';
import 'package:health_bag/pages/common/auth/otpPage.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String actualCode;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;
  @observable
  bool isPatientReg = true;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> patientRegKey = GlobalKey<ScaffoldState>();

  @observable
  User firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential auth) async {
          await _auth.signInWithCredential(auth).then((UserCredential value) {
            if (value != null && value.user != null) {
              print('Authentication successful');
              onAuthenticationSuccessful(context, value);
            } else {
              loginScaffoldKey.currentState.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: MyColors.black,
                content: MyFonts().body(
                    'Invalid code/invalid authentication', MyColors.white),
              ));
            }
          }).catchError((error) {
            loginScaffoldKey.currentState.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: MyColors.black,
              content: MyFonts().body(
                  'Something has gone wrong, please try later', MyColors.white),
            ));
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print('Error message: ' + authException.message);
          loginScaffoldKey.currentState.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: MyColors.black,
            content: MyFonts().body(
                'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]',
                MyColors.white),
          ));
          isLoginLoading = false;
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          actualCode = verificationId;
          isLoginLoading = false;
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) =>  const OtpPage()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          actualCode = verificationId;
        });
  }

  @action
  Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      otpScaffoldKey.currentState.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: MyColors.black,
        content: MyFonts().body(
            'Wrong code ! Please enter the last code received.',
            MyColors.white),
      ));
      // ignore: non_constant_identifier_names
    }).then((UserCredential UserCredential) {
      if (UserCredential != null && UserCredential.user != null) {
        print('Authentication successful');
        onAuthenticationSuccessful(context, UserCredential);
      }
    });
  }

  Future<void> onAuthenticationSuccessful(
      BuildContext context, UserCredential result) async {
    isLoginLoading = true;
    isOtpLoading = true;

    firebaseUser = result.user;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => UserType()),
        (Route<dynamic> route) => false);

    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => Welcome()),
        (Route<dynamic> route) => false);
    firebaseUser = null;
  }
}
