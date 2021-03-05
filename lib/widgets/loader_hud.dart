import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';

class LoaderHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator = Container(
    width: 300,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: MyColors.white,
    ),
    child: Material(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Row(
          children: [
            CircularProgressIndicator(),
            Spacer(),
            MyFonts().body('Loading', MyColors.black)
          ],
        ),
      ),
    ),
  );
  final bool dismissible;
  final Widget child;

  LoaderHUD({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = MyColors.gray,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return Stack(
      children: [
        child,
        Opacity(
          child: ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        Center(child: progressIndicator),
      ],
    );
  }
}
