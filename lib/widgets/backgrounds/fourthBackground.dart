import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';

class FourthBackground extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Material(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: MyColors.blue,
            child: CustomPaint(
              painter: OpenPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter{
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = MyColors.blueLighter
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(0, 0, size.height/1.5, size.width/1.5),paint1);

    var paint2 = Paint()
      ..color = MyColors.red
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromLTWH(-150, 0, 300, 300),paint2);

    var paint3 = Paint()
      ..color = MyColors.backgroundColor
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.15,
        size.width * 0.5, size.height * 0.15);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.15,
        size.width * 1.0, size.height * 0.15);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint3);
  }
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}