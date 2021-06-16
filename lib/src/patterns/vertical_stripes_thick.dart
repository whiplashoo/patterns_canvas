import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class VerticalStripesThick extends Pattern {
  final Color bgColor;
  final Color fgColor;
  final int stripesCount = 60;
  String get description => "Vertical Stripes Thick";

  const VerticalStripesThick({required this.bgColor, required this.fgColor})
      : super(patternType: PatternType.verticalThick, bgColor: bgColor, fgColor: fgColor);

  void paintWithPattern(Canvas canvas, double x, double y, double width, double height) {
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
