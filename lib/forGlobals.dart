library firstapp.globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String studentId = "";
String studentaddress = "";
String studentphoneno = '';
String point = '';
String studentname = '';
String Driverid = "";
String driverName = "";

class User {
  static double lat = 0;
  static double long = 0;
  static String id = '';
  static String userId = '';
}

class CardCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.32);
    path.quadraticBezierTo(size.width * 0.24, size.height * 0.45,
        size.width * 0.49, size.height * 0.45);
    path.quadraticBezierTo(
        size.width * 0.73, size.height * 0.45, size.width, size.height * 0.32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
