import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../pattern.dart';

class DiagonalStripesThick extends Pattern {
  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final int featuresCount;
  String get description => "Diagonal Stripes Thick";

  /// Paints a [Pattern] made of 15 thick diagonal stripes across the largest
  /// side with the foreground color as the stripe color.
  ///
  /// Example:
  ///
  /// ```dart
  /// DiagonalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
  /// ```
  const DiagonalStripesThick(
      {required this.bgColor,
      required this.fgColor,
      this.featuresCount = Pattern.DEFAULT_DIAGONAL_STRIPES_COUNT})
      : super(
            patternType: PatternType.diagonalThick,
            bgColor: bgColor,
            fgColor: fgColor);

  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height) {
    final stripesCount = featuresCount;
    final maxDimension = max(width, height);
    final stripeW = maxDimension / stripesCount / 2;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = bgColor;
    canvas.drawRect(Rect.fromLTWH(x, y, width, height), paint);
    final rectStripesCount =
        stripesCount * 2.5; // to make sure we cover the whole rectangle;
    var step = stripeW * 3;
    final allStripesPath = Path();
    for (var i = 1; i < rectStripesCount; i += 2) {
      final stripePath = Path();
      stripePath.moveTo(x - stripeW + step, y);
      stripePath.lineTo(x + step, y);
      stripePath.lineTo(x, y + step);
      stripePath.lineTo(x - stripeW, y + step);
      stripePath.close();
      allStripesPath.addPath(stripePath, Offset.zero);
      step += stripeW * 3;
    }
    paint
      ..style = PaintingStyle.fill
      ..color = fgColor;
    canvas.drawPath(allStripesPath, paint);
  }
}
