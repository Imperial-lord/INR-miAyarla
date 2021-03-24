import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';

class MultilineRow{
  Widget getMultilineRow(
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MyFonts().heading2(heading, MyColors.gray),
        ),
        CupertinoTextField(
          enabled: toggleEnabled,
          expands: false,
          maxLines: lines,
          padding: EdgeInsets.all(15),
          placeholder: placeholder,
          decoration: BoxDecoration(
              color: MyColors.backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          prefix: Padding(padding: const EdgeInsets.all(10), child: icon),
          style: TextStyle(
              fontFamily: 'poppins-semi',
              fontSize: 17,
              color: (toggleEnabled) ? MyColors.black : MyColors.gray),
          controller: controller,
          keyboardType: textInputType,
          textInputAction: TextInputAction.newline,
        ),
      ],
    );
  }
}