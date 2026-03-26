import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class Dots extends Pattern {
  final int featuresCount;
  @override
  String get description => "Dots";

  /// Paints a [Pattern] made of 10 circles (dots) inside bigger squares across the object's
  /// larger side with the foreground color as the circle's color.
  ///
  /// Example:
  ///
  /// ```dart
  /// Dots(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const Dots(
      {required super.bgColor,
      required super.fgColor,
      this.featuresCount = Pattern.defaultDotsCount})
      : super(patternType: PatternType.dots);

  @override
  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    var rectSide = maxDimension / featuresCount;
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
