import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class Raindrops extends Pattern {
  final Color bgColor;
  final Color fgColor;
  final int dropsCount = 20;

  const Raindrops({required this.bgColor, required this.fgColor})
      : super(patternType: PatternType.raindrops, bgColor: bgColor, fgColor: fgColor);

  void paintWithPattern(Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    var rectSide = maxDimension / dropsCount;
    var horizontalSquaresCount = width / rectSide;
    var verticalSquaresCount = height / rectSide;

    final dropsPath = Path();
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

    var dx = 0.0, dy = 0.0;
    for (var j = 0; j < verticalSquaresCount; j++) {
      for (var i = 0; i < horizontalSquaresCount; i++) {
        final rectX = x + dx + rectSide / 8; // Start a bit to the right.
        final rectY = y + dy;
        final path = Path();
        path.moveTo(rectX + rectSide / 5, rectY + rectSide / 5);
        path.lineTo(rectX + rectSide * 2 / 5, rectY + rectSide * 1.5 / 5);
        path.lineTo(rectX + rectSide * 3 / 5, rectY + rectSide * 3 / 5);
        path.lineTo(rectX + rectSide * 2 / 5, rectY + rectSide * 3.5 / 5);
        path.lineTo(rectX + rectSide * 1 / 5, rectY + rectSide * 2 / 5);
        path.close();
        dropsPath.addPath(path, Offset.zero);
        dx += rectSide;
      }
      dy += rectSide;
      dx = 0;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(dropsPath, paint);
  }
}
