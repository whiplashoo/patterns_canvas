import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class HorizontalStripesLight extends Pattern {
  final int featuresCount;

  @override
  String get description => "Horizontal Stripes Light";

  /// Paints a [Pattern] made of 10 thin horizontal stripes across the object's height
  /// with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// HorizontalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const HorizontalStripesLight(
      {required super.bgColor,
      required super.fgColor,
      this.featuresCount = Pattern.defaultStripesCount})
      : super(patternType: PatternType.horizontalLight);

  @override
  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final stripesCount = featuresCount * 2;
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
