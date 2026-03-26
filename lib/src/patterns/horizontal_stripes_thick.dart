import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class HorizontalStripesThick extends Pattern {
  final int featuresCount;

  @override
  String get description => "Horizontal Stripes Thick";

  /// Paints a [Pattern] made of 10 thick horizontal stripes across the object's height
  /// with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// HorizontalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const HorizontalStripesThick(
      {required super.bgColor,
      required super.fgColor,
      this.featuresCount = Pattern.defaultStripesCount})
      : super(patternType: PatternType.horizontalThick);

  @override
  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final stripesCount = featuresCount * 2;
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
