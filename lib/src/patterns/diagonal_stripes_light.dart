import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class DiagonalStripesLight extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int stripesCount = 40;
  String get description => "Diagonal Stripes Light";

  /// Paints a [Pattern] made of 40 thin diagonal stripes across the largest
  /// side with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// DiagonalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const DiagonalStripesLight({required this.bgColor, required this.fgColor})
      : super(patternType: PatternType.diagonalLight, bgColor: bgColor, fgColor: fgColor);

  void paintWithPattern(Canvas canvas, double x, double y, double width, double height) {
    final maxDimension = max(width, height);
    final stripeW = maxDimension / stripesCount / 6;
    var step = stripeW * 9;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    final rectStripesCount = stripesCount * 2.5; // to make sure we cover the whole rectangle
    for (var i = 1; i < rectStripesCount; i += 2) {
      final p1 = Offset(x + step, y);
      final p2 = Offset(x, y + step);
      paint
        ..color = fgColor
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stripeW;
      canvas.drawLine(p1, p2, paint);
      step += stripeW * 9;
    }
  }
}
