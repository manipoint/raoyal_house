import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:raoyal_house/app%20utils/app_properties.dart';

class AuthBackground extends CustomPainter {
  AuthBackground({
    required this.image,
  });

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
   
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
   canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), Paint()..color = transparentYellow);
  }

    @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MainBackground extends CustomPainter {

  MainBackground();

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
canvas.drawRect(
        Rect.fromLTRB(
            0, 0,width, height),
        Paint()..color = Colors.white);
    canvas.drawRect(
        Rect.fromLTRB(
            width - (width / 3), 0,width, height),
        Paint()..color = transparentYellow);
        
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
