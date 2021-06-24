import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class Crosshatch extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int featuresCount;
  String get description => "Crosshatch";

  /// Paints a [Pattern] made of 10 diamond shapes across the largest side
  /// with the foreground color as their border color.
  ///
  /// Example:
  ///
  /// ```dart
  /// Crosshatch(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const Crosshatch(
      {required this.bgColor,
      required this.fgColor,
      this.featuresCount = Pattern.DEFAULT_SQUARES_COUNT})
      : super(
            patternType: PatternType.crosshatch,
            bgColor: bgColor,
            fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    var rectSide = maxDimension / featuresCount;
    var horizontalSquaresCount = width / rectSide;
    var verticalSquaresCount = height / rectSide;

    final linesPath = Path();
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);

    var dx = 0.0, dy = 0.0;
    for (var j = 0; j < verticalSquaresCount; j++) {
      for (var i = 0; i < horizontalSquaresCount; i++) {
        final rectX = x + dx;
        final rectY = y + dy;
        final path = Path();
        path.moveTo(rectX, rectY + rectSide / 2);
        path.lineTo(rectX + rectSide / 2, rectY);
        path.lineTo(rectX + rectSide, rectY + rectSide / 2);
        path.lineTo(rectX + rectSide / 2, rectY + rectSide);
        path.close();
        linesPath.addPath(path, Offset.zero);
        dx += rectSide;
      }
      dy += rectSide;
      dx = 0;
    }
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = fgColor;
    canvas.drawPath(linesPath, paint);
  }
}
