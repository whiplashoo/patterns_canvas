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

/// The available [Pattern] types. Use in the [Pattern.fromValues] constructor.
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

/// Changes how the pattern is drawn on the [Canvas] shape or
/// [Widget]. Used in the [paintOn] methods of each [Pattern].
///
/// All patterns are by default scaled to their container
/// ([PatternScaleBehavior.container]). This means that, regardless
/// of its size, a `Rectangle` will contain 40 diagonal stripes or 40 dots.
///
/// Use [PatternScaleBehavior.canvas] to scale the pattern to the whole [Canvas]
/// area. Now the `Canvas` will contain 40 diagonal stripes or 40 dots, so, a
/// `Rectangle` will contain as many dots or stripes as it can fit.
///
/// ```dart
/// Pattern p = DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor);
/// p.paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.canvas);
/// ```
///
/// Use [PatternScaleBehavior.customRect] and a [customRect] (e.g. a [Rectangle] with
/// half the [Canvas] height) to further customize the [Pattern] size:
///
/// ```dart
/// Rect halfCanvas = Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2);
/// p.paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.customRect
/// , customRect: halfCanvas);
/// ```
enum PatternScaleBehavior { container, customRect, canvas }

///You can construct a [Pattern] with three different ways:
///
///- Directly with a [Pattern] type constructor:
///```dart
///final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
///```
///
///- With the [Pattern.fromValues] factory constructor:
///```dart
///final Pattern p2 = Pattern.fromValues(patternType: PatternType.diagonalLight, bgColor: Colors.yellowAccent, fgColor: Colors.black);
///```
///
///- From a String representation in the form of "pattern_backgroundHex_foregroundHex":
///```dart
///final Pattern p3 = Pattern.fromString("diagonalLight_ffff00_000000");
///```
abstract class Pattern {
  static const DEFAULT_STRIPES_COUNT = 10;
  static const DEFAULT_SQUARES_COUNT = 10;
  static const DEFAULT_DOTS_COUNT = 10;
  static const DEFAULT_DIAGONAL_STRIPES_COUNT = 15;

  /// The [Pattern]'s background color.
  final Color bgColor;

  /// The [Pattern]'s foreground color (for the stripes, dots, squares, etc.).
  final Color fgColor;
  final PatternType patternType;
  String get description => "Pattern";

  const Pattern(
      {required this.patternType,
      required this.bgColor,
      required this.fgColor});

  /// Instantiate a [Pattern] from a String representation in the form
  /// of "pattern_backgroundHex_foregroundHex".
  factory Pattern.fromString(String stringDescription) {
    var splitDescription = stringDescription.split("_");
    PatternType patternType = PatternType.values.firstWhere(
        (e) => e.toString() == 'PatternType.' + splitDescription.first);
    Color bgColor = hexOrRGBToColor('#' + splitDescription[1]);
    Color fgColor = hexOrRGBToColor('#' + splitDescription.last);
    return Pattern.fromValues(
        patternType: patternType, bgColor: bgColor, fgColor: fgColor);
  }

  /// Instantiate a [Pattern] from a type, background and foreground colors.
  factory Pattern.fromValues(
      {required PatternType patternType,
      required Color bgColor,
      required Color fgColor,
      int? featuresCount}) {
    if (patternType == PatternType.dots)
      return Dots(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    if (patternType == PatternType.verticalThick)
      return VerticalStripesThick(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_STRIPES_COUNT);
    if (patternType == PatternType.verticalLight)
      return VerticalStripesLight(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_STRIPES_COUNT);
    if (patternType == PatternType.diagonalThick)
      return DiagonalStripesThick(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_DIAGONAL_STRIPES_COUNT);
    if (patternType == PatternType.diagonalLight)
      return DiagonalStripesLight(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_DIAGONAL_STRIPES_COUNT);
    if (patternType == PatternType.horizontalLight)
      return HorizontalStripesLight(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_STRIPES_COUNT);
    if (patternType == PatternType.horizontalThick)
      return HorizontalStripesThick(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_STRIPES_COUNT);
    if (patternType == PatternType.subtlepatch)
      return SubtlePatch(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    if (patternType == PatternType.texture)
      return TexturePattern(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    if (patternType == PatternType.raindrops)
      return Raindrops(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    if (patternType == PatternType.checkers)
      return Checkers(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    if (patternType == PatternType.crosshatch)
      return Crosshatch(
          bgColor: bgColor,
          fgColor: fgColor,
          featuresCount: featuresCount ?? DEFAULT_SQUARES_COUNT);
    throw "Can't create pattern";
  }

  /// After clipping the canvas to the shape we want, paint the [Pattern] on the rectangle
  /// defined by the provided [x], [y], [width], [height].
  void paintWithPattern(
      Canvas canvas, double x, double y, double width, double height);

  /// Paint the [Pattern] on the whole [Canvas] size.
  void paintOnCanvas(Canvas canvas, Size size) {
    paintWithPattern(canvas, 0.0, 0.0, size.width, size.height);
  }

  /// Paint the [Pattern] on a widget.
  ///
  /// The widget must be wrapped inside a CustomPaint first.
  ///
  /// Rectangular widgets, like Containers, Rows, Columns, IconButtons, etc. can be
  /// painted directly with the above method. For widgets that have a custom shape,
  /// like a [BottomAppbar], you need to provide a different [clipBehavior] property,
  /// e.g. [Clip.antiAlias], to make sure the pattern is clipped to the special shape.
  /// Check the second screen in the example app for more.
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the [Pattern] to.
  void paintOnWidget(Canvas canvas, Size size,
      {PatternScaleBehavior patternScaleBehavior =
          PatternScaleBehavior.container,
      Rect? customRect}) {
    canvas.save();
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    canvas.clipRect(rect);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        paintWithPattern(canvas, 0.0, 0.0, size.width, size.height);
        break;
      case PatternScaleBehavior.canvas:
        Size screenSize = WidgetsBinding.instance!.window.physicalSize /
            WidgetsBinding.instance!.window.devicePixelRatio;
        paintOnCanvas(canvas, screenSize);
        break;
      case PatternScaleBehavior.customRect:
        (customRect != null)
            ? paintWithPattern(canvas, customRect.left, customRect.top,
                customRect.width, customRect.height)
            : paintOnCanvas(canvas, size);
        break;
    }
    canvas.restore();
  }

  /// Paint the [Pattern] on a [Path].
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the [Pattern] to.
  void paintOnPath(Canvas canvas, Size size, Path path,
      {PatternScaleBehavior patternScaleBehavior =
          PatternScaleBehavior.container,
      Rect? customRect}) {
    canvas.save();
    canvas.clipPath(path);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        final Rect boundsRect = path.getBounds();
        final pathW = boundsRect.width,
            pathH = boundsRect.height,
            pathX = boundsRect.left,
            pathY = boundsRect.top;
        paintWithPattern(canvas, pathX, pathY, pathW, pathH);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        (customRect != null)
            ? paintWithPattern(canvas, customRect.left, customRect.top,
                customRect.width, customRect.height)
            : paintOnCanvas(canvas, size);
        break;
    }
    canvas.restore();
  }

  /// Paint the [Pattern] on a [Rect].
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the [Pattern] to.
  void paintOnRect(Canvas canvas, Size size, Rect rect,
      {PatternScaleBehavior patternScaleBehavior =
          PatternScaleBehavior.container,
      Rect? customRect}) {
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
        paintWithPattern(canvas, customRect!.left, customRect.top,
            customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }

  /// Paint the [Pattern] on a [RRect].
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the [Pattern] to.
  void paintOnRRect(Canvas canvas, Size size, RRect rRect,
      {PatternScaleBehavior patternScaleBehavior =
          PatternScaleBehavior.container,
      Rect? customRect}) {
    canvas.save();
    canvas.clipRRect(rRect);
    switch (patternScaleBehavior) {
      case PatternScaleBehavior.container:
        paintWithPattern(
            canvas, rRect.left, rRect.top, rRect.width, rRect.height);
        break;
      case PatternScaleBehavior.canvas:
        paintOnCanvas(canvas, size);
        break;
      case PatternScaleBehavior.customRect:
        paintWithPattern(canvas, customRect!.left, customRect.top,
            customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }

  /// Paint the [Pattern] on a [Circle], defined by a [center] [Offset] and a [radius].
  ///
  /// If [PatternScaleBehavior.customRect] is specified, you must also provide a [customRect]
  /// to scale the [Pattern] to.
  void paintOnCircle(Canvas canvas, Size size, Offset center, double radius,
      {PatternScaleBehavior patternScaleBehavior =
          PatternScaleBehavior.container,
      Rect? customRect}) {
    canvas.save();
    final Rect rect =
        Rect.fromCircle(center: Offset(center.dx, center.dy), radius: radius);
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
        paintWithPattern(canvas, customRect!.left, customRect.top,
            customRect.width, customRect.height);
        break;
    }
    canvas.restore();
  }
}
