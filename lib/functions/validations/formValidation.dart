import 'package:flutter/cupertino.dart';

class FormValidation {
  bool emailValidation(String email) {
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool ageValidation(String age) {
    return age == '0';
  }

  bool emptyFieldsValidation(List<TextEditingController> controllers) {
    for (var i = 0; i < controllers.length; i++) {
      if(controllers[i].text=='')
        return true;
    }
    return false;
  }

  bool phoneNumberValidation(String number){
    String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(number);
  }
}
