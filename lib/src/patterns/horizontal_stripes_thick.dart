import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class HorizontalStripesThick extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int stripesCount = 60;
  String get description => "Horizontal Stripes Thick";

  /// Paints a [Pattern] made of 40 thick horizontal stripes across the object's height
  /// with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// HorizontalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const HorizontalStripesThick({required this.bgColor, required this.fgColor})
      : super(
            patternType: PatternType.horizontalThick,
            bgColor: bgColor,
            fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    var stripeH = height / stripesCount / 1.5;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    var dy = 0.0;
    final rectsPath = Path();
    for (var i = 1; i < stripesCount; i += 2) {
      // Start the pattern from half a background stripe height.
      final rect = Rect.fromLTWH(x, y + dy + stripeH, width, stripeH);
      rectsPath.addRect(rect);
      dy += stripeH * 3;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(rectsPath, paint);
  }
}
