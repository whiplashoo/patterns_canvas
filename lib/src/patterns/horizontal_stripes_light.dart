import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class HorizontalStripesLight extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int stripesCount = 30;
  String get description => "Horizontal Stripes Light";

  /// Paints a [Pattern] made of 30 thin horizontal stripes across the object's height
  /// with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// HorizontalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const HorizontalStripesLight({required this.bgColor, required this.fgColor})
      : super(
            patternType: PatternType.horizontalLight,
            bgColor: bgColor,
            fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final stripeH = height / stripesCount / 6;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    var dy = 0.0;
    final rectsPath = Path();
    for (var i = 0; i < stripesCount; i++) {
      final rect = Rect.fromLTWH(x, y + dy + stripeH, width, stripeH);
      rectsPath.addRect(rect);
      dy += stripeH * 12;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(rectsPath, paint);
  }
}
