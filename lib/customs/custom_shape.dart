
import 'package:flutter/cupertino.dart';
import 'package:parking_project/constant_colors.dart';

class CustomShape extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    Path path = Path();
    path.lineTo(-20, size.height - 100);
    path.quadraticBezierTo( size.width * 0.5, size.height,size.width, size.height-140);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, Paint()..color = kPrimaryColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}