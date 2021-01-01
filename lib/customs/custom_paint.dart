import 'package:flutter/material.dart';

class CustomPaints extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();


    // Path number 1


    paint.color = Color(0xfff5f5f5);
    path = Path();
    path.lineTo(0, size.height * 0.87);
    path.cubicTo(size.width * 0.01, size.height * 0.91, size.width * 0.01, size.height * 0.96, size.width * 0.03, size.height);
    path.cubicTo(size.width * 0.03, size.height, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width, size.height, size.width, 0, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.68, 0, size.width * 0.68, 0);
    path.cubicTo(size.width * 0.68, 0, size.width * 0.56, -0.01, size.width * 0.43, size.height * 0.1);
    path.cubicTo(size.width * 0.43, size.height * 0.1, size.width * 0.42, size.height * 0.1, size.width * 0.42, size.height * 0.11);
    path.cubicTo(size.width * 0.4, size.height * 0.13, size.width * 0.38, size.height * 0.14, size.width * 0.37, size.height * 0.17);
    path.cubicTo(size.width / 3, size.height * 0.22, size.width * 0.31, size.height * 0.29, size.width * 0.3, size.height * 0.36);
    path.cubicTo(size.width * 0.29, size.height * 0.42, size.width * 0.28, size.height * 0.49, size.width * 0.24, size.height * 0.55);
    path.cubicTo(size.width * 0.24, size.height * 0.55, size.width * 0.24, size.height * 0.55, size.width * 0.23, size.height * 0.55);
    path.cubicTo(size.width / 5, size.height * 0.59, size.width * 0.17, size.height * 0.62, size.width * 0.12, size.height * 0.64);
    path.cubicTo(size.width * 0.07, size.height * 0.66, size.width * 0.04, size.height * 0.69, size.width * 0.03, size.height * 0.72);
    path.cubicTo(0, size.height * 0.77, 0, size.height * 0.82, 0, size.height * 0.87);
    path.cubicTo(0, size.height * 0.87, 0, size.height * 0.87, 0, size.height * 0.87);
    canvas.drawPath(path, paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }



}