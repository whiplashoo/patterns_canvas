import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class Dots extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int circlesCount = 10;
  String get description => "Dots";

  /// Paints a [Pattern] made of 10 circles (dots) inside bigger squares across the object's
  /// larger side with the foreground color as the circle's color.
  ///
  /// Example:
  ///
  /// ```dart
  /// Dots(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const Dots({required this.bgColor, required this.fgColor})
      : super(
            patternType: PatternType.dots, bgColor: bgColor, fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    var rectSide = maxDimension / circlesCount;
    var horizontalSquaresCount = width / rectSide;
    var verticalSquaresCount = height / rectSide;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

    var dx = 0.0, dy = 0.0;
    final dotsPath = Path();
    for (var j = 0; j < verticalSquaresCount; j++) {
      for (var i = 0; i < horizontalSquaresCount; i++) {
        paint
          ..style = PaintingStyle.fill
          ..color = fgColor;
        Rect oval = Rect.fromCircle(
            center: Offset(x + dx + rectSide / 2, y + dy + rectSide / 2),
            radius: rectSide / 4);
        dotsPath.addOval(oval);
        dx += rectSide;
      }
      dy += rectSide;
      dx = 0;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(dotsPath, paint);
  }
}
