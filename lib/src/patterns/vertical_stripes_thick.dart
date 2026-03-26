import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class VerticalStripesThick extends Pattern {
  final int featuresCount;

  @override
  String get description => "Vertical Stripes Thick";

  /// Paints a [Pattern] made of 10 thick vertical stripes across the object's width
  /// with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// VerticalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const VerticalStripesThick(
      {required super.bgColor,
      required super.fgColor,
      this.featuresCount = Pattern.defaultStripesCount})
      : super(patternType: PatternType.verticalThick);

  @override
  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final stripesCount = featuresCount * 2;
    var stripeW = width / stripesCount / 1.5;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    var dx = 0.0;
    final rectsPath = Path();
    for (var i = 1; i < stripesCount; i += 2) {
      // Start the pattern from half a background stripe width.
      final rect = Rect.fromLTWH(x + dx + stripeW, y, stripeW, height);
      rectsPath.addRect(rect);
      dx += stripeW * 3;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(rectsPath, paint);
  }
}
