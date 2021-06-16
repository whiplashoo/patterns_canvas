import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class DiagonalStripesThick extends Pattern {
  final Color bgColor;
  final Color fgColor;
  final int stripesCount = 40;
  String get description => "Diagonal Stripes Thick";

  const DiagonalStripesThick({required this.bgColor, required this.fgColor})
      : super(patternType: PatternType.diagonalThick, bgColor: bgColor, fgColor: fgColor);

  void paintWithPattern(Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    final stripeW = maxDimension / stripesCount / 2;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    final rectStripesCount = stripesCount * 2.5; // to make sure we cover the whole rectangle;
    var step = stripeW * 3;
    for (var i = 1; i < rectStripesCount; i += 2) {
      final p1 = Offset(x + step, y);
      final p2 = Offset(x, y + step);
      paint
        ..color = fgColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stripeW;
      canvas.drawLine(p1, p2, paint);
      step += stripeW * 3;
    }
  }
}
