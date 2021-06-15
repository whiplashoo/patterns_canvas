import 'dart:ui';

import 'package:flutter/material.dart';

import 'patterns/checkers.dart';
import 'patterns/crosshatch.dart';
import 'patterns/diagonal_stripes_light.dart';
import 'patterns/diagonal_stripes_thick.dart';
import 'patterns/dots.dart';
import 'patterns/horizontal_stripes_light.dart';
import 'patterns/horizontal_stripes_thick.dart';
import 'patterns/raindrops.dart';
import 'patterns/subtle_patch.dart';
import 'patterns/texture.dart';
import 'patterns/vertical_stripes_light.dart';
import 'patterns/vertical_stripes_thick.dart';
import 'utils/utils.dart';

enum PatternType {
  dots,
  diagonalLight,
  diagonalThick,
  verticalLight,
  verticalThick,
  horizontalLight,
  horizontalThick,
  crosshatch,
  subtlepatch,
  checkers,
  raindrops,
  texture
}

enum PatternScaleBehavior { container, customRect, canvas }

abstract class Pattern {
  final Color bgColor;
  final Color fgColor;
  final PatternType patternType;

  const Pattern({required this.patternType, required this.bgColor, required this.fgColor});

  factory Pattern.fromString(String stringDescription) {
    var splitDescription = stringDescription.split("_");
    PatternType patternType =
        PatternType.values.firstWhere((e) => e.toString() == 'PatternType.' + splitDescription.first);
    Color bgColor = hexOrRGBToColor('#' + splitDescription[1]);
    Color fgColor = hexOrRGBToColor('#' + splitDescription.last);
    return Pattern.fromValues(patternType: patternType, bgColor: bgColor, fgColor: fgColor);
  }

  factory Pattern.fromValues({required PatternType patternType, required Color bgColor, required Color fgColor}) {
    if (patternType == PatternType.dots) return Dots(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.verticalThick) return VerticalStripesThick(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.verticalLight) return VerticalStripesLight(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.diagonalThick) return DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.diagonalLight) return DiagonalStripesLight(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.horizontalLight) return HorizontalStripesLight(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.horizontalThick) return HorizontalStripesThick(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.subtlepatch) return SubtlePatch(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.texture) return TexturePattern(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.raindrops) return Raindrops(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.checkers) return Checkers(bgColor: bgColor, fgColor: fgColor);
    if (patternType == PatternType.crosshatch) return Crosshatch(bgColor: bgColor, fgColor: fgColor);
    throw "Can't create pattern";
  }

  void paintWithPattern(Canvas canvas, double x, double y, double width, double height);

  void paintOnCanvas(Canvas canvas, Size size) {
    paintWithPattern(canvas, 0.0, 0.0, size.width, size.height);
  }

  ///
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the pattern to.
  void paintOnPath(Canvas canvas, Size size, Path path,
      {PatternScaleBehavior patternScaleBehavior = PatternScaleBehavior.container, Rect? customRect}) {
    canvas.save();
    canvas.clipPath(path);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        final Rect boundsRect = path.getBounds();
        final pathW = boundsRect.width, pathH = boundsRect.height, pathX = boundsRect.left, pathY = boundsRect.top;
        paintWithPattern(canvas, pathX, pathY, pathW, pathH);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        (customRect != null)
            ? paintWithPattern(canvas, customRect.left, customRect.top, customRect.width, customRect.height)
            : paintOnCanvas(canvas, size);
        break;
    }
    canvas.restore();
  }

  void paintOnRect(Canvas canvas, Size size, Rect rect,
      {PatternScaleBehavior patternScaleBehavior = PatternScaleBehavior.container, Rect? customRect}) {
    canvas.save();
    canvas.clipRect(rect);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        paintWithPattern(canvas, rect.left, rect.top, rect.width, rect.height);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        paintWithPattern(canvas, customRect!.left, customRect.top, customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }

  void paintOnRRect(Canvas canvas, Size size, RRect rRect,
      {PatternScaleBehavior patternScaleBehavior = PatternScaleBehavior.container, Rect? customRect}) {
    canvas.save();
    canvas.clipRRect(rRect);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        paintWithPattern(canvas, rRect.left, rRect.top, rRect.width, rRect.height);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        paintWithPattern(canvas, customRect!.left, customRect.top, customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }

  void paintOnCircle(Canvas canvas, Size size, Offset c, double radius,
      {PatternScaleBehavior patternScaleBehavior = PatternScaleBehavior.container, Rect? customRect}) {
    canvas.save();
    final Rect rect = Rect.fromCircle(center: Offset(c.dx, c.dy), radius: radius);
    final Path circle = Path()..addOval(rect);
    canvas.clipPath(circle);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        paintWithPattern(canvas, rect.left, rect.top, rect.width, rect.height);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        paintWithPattern(canvas, customRect!.left, customRect.top, customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }
}
