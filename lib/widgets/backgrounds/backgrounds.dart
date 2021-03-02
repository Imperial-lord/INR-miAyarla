import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';

// TODO: Delete this file later after making other backgrounds!
class Backgrounds extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: MyColors.blue,
        child: CustomPaint(
          painter: OpenPainter(),
          // painter:CurvePainter()
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

    // canvas.drawOval(Rect.fromLTWH(0, 0, size.height/2, size.width/1.5),paint1);
    // canvas.drawCircle(Offset(size.width,size.width/3),size.width/6,paint1);
    canvas.drawCircle(Offset(size.width/2, size.height/1.3), size.width/2, paint1);

    var paint2 = Paint()
      ..color = MyColors.red
      ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(0, 0), 150, paint2);
    canvas.drawCircle(Offset(size.width, size.height), 100, paint2);

    var paint3 = Paint()
      ..color = MyColors.white
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.5,
        size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint3);
  }
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}