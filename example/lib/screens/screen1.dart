import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painting patterns on canvas elements'),
      ),
      body: Center(
        child: InteractiveViewer(
          constrained: false,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              isComplex: true,
              willChange: true,
              painter: MyPainter(context),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final BuildContext context;

  MyPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    // Prepare the canvas elements to draw on.
    final Rect rect1 = Rect.fromLTWH(30, 50, 125, 75);
    final Rect rect2 = Rect.fromLTWH(30, 150, 125, 75);
    final Rect rect3 = Rect.fromLTWH(30, 250, 125, 75);
    final RRect rRect = RRect.fromLTRBR(190, 50, 325, 125, Radius.circular(45));

    final Path rightPath = Path();
    rightPath.lineTo(size.width, size.height / 5);
    rightPath.cubicTo(
        size.width, size.height / 5, size.width * 0.9, size.height * 0.88, size.width * 0.3, size.height * 0.93);
    rightPath.cubicTo(size.width * 0.36, size.height * 0.97, size.width / 5, size.height, size.width / 5, size.height);
    rightPath.cubicTo(size.width / 5, size.height, size.width, size.height, size.width, size.height);
    rightPath.cubicTo(size.width, size.height, size.width, size.height / 5, size.width, size.height / 5);

    final Path catPath = createCatPath(size);

    // Painting the whole canvas with a pattern:
    SubtlePatch(bgColor: Colors.white, fgColor: Color(0xffd1dbdd)).paintOnCanvas(canvas, size);

    // You can construct a Pattern with three different ways:
    // 1. Directly through a pattern type constructor:
    final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
    p1.paintOnRect(canvas, size, rect1);

    // 2. With the Pattern.fromValues factory constructor:
    final Pattern p2 =
        Pattern.fromValues(patternType: PatternType.checkers, bgColor: Colors.blueGrey, fgColor: Colors.deepOrange);
    p2.paintOnRect(canvas, size, rect2);

    // 3. From a String shorthand in the form of `pattern_backgroundHex_foregroundHex`:
    final Pattern p3 = Pattern.fromString("verticalThick_e17c05_525252");
    p3.paintOnRect(canvas, size, rect3);

    // You can also draw Patterns on a RRect:
    DiagonalStripesThick(bgColor: Colors.greenAccent, fgColor: Colors.black).paintOnRRect(canvas, size, rRect);

    // Or on a Circle:
    HorizontalStripesThick(bgColor: Colors.blueGrey, fgColor: Colors.yellowAccent)
        .paintOnCircle(canvas, size, Offset(250, 185), 40.0);

    // You can also control how the pattern scales to its containing element (more on this in the second example):
    HorizontalStripesThick(bgColor: Colors.blueGrey, fgColor: Colors.yellowAccent)
        .paintOnCircle(canvas, size, Offset(250, 285), 40.0, patternScaleBehavior: PatternScaleBehavior.canvas);

    // Drawing on any kind of Path element:
    Crosshatch(bgColor: Colors.blueGrey, fgColor: Colors.yellowAccent).paintOnPath(canvas, size, rightPath);
    Dots(bgColor: Color(0xfffdbf6f), fgColor: Color(0xff525252)).paintOnPath(canvas, size, catPath,
        patternScaleBehavior: PatternScaleBehavior.customRect,
        customRect: Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path createCatPath(Size size) {
    double w = 155;
    double h = 160;
    Path catBodyPath = Path();
    catBodyPath.lineTo(w * 0.63, h * 0.05);
    catBodyPath.cubicTo(w * 0.63, h * 0.05, w * 0.61, h * 0.19, w * 0.61, h * 0.19);
    catBodyPath.cubicTo(w * 0.61, h * 0.19, w * 0.57, h * 0.24, w * 0.57, h * 0.31);
    catBodyPath.cubicTo(w * 0.57, h * 0.38, w * 0.63, h * 0.43, w * 0.63, h * 0.43);
    catBodyPath.cubicTo(w * 0.48, h * 0.43, w * 0.29, h * 0.6, w * 0.29, h * 0.83);
    catBodyPath.cubicTo(w * 0.29, h * 0.87, w * 0.29, h * 0.9, w * 0.29, h * 0.92);
    catBodyPath.cubicTo(w * 0.23, h * 0.88, w * 0.18, h * 0.78, w * 0.18, h * 0.67);
    catBodyPath.cubicTo(w * 0.18, h * 0.55, w * 0.3, h * 0.24, w * 0.3, h * 0.19);
    catBodyPath.cubicTo(w * 0.3, h * 0.13, w * 0.26, h * 0.09, w / 5, h * 0.09);
    catBodyPath.cubicTo(w * 0.14, h * 0.09, w * 0.09, h * 0.13, w * 0.09, h * 0.19);
    catBodyPath.cubicTo(w * 0.09, h * 0.22, w * 0.11, h * 0.24, w * 0.14, h * 0.24);
    catBodyPath.cubicTo(w * 0.17, h * 0.24, w * 0.19, h * 0.22, w / 5, h / 5);
    catBodyPath.cubicTo(w * 0.18, h * 0.27, w * 0.07, h * 0.56, w * 0.07, h * 0.67);
    catBodyPath.cubicTo(w * 0.07, h * 0.88, w / 5, h * 1.05, w * 0.38, h * 1.05);
    catBodyPath.cubicTo(w * 0.38, h * 1.05, w * 0.39, h * 1.05, w * 0.39, h * 1.05);
    catBodyPath.cubicTo(w * 0.39, h * 1.05, w * 0.73, h * 1.05, w * 0.73, h * 1.05);
    catBodyPath.cubicTo(w * 0.73, h * 1.05, w * 0.95, h * 1.05, w * 0.95, h * 1.05);
    catBodyPath.cubicTo(w * 0.95, h * 1.05, w * 1.02, h * 0.43, w * 1.02, h * 0.43);
    catBodyPath.cubicTo(w * 1.02, h * 0.43, w * 1.07, h * 0.38, w * 1.07, h * 0.31);
    catBodyPath.cubicTo(w * 1.07, h * 0.24, w * 1.04, h * 0.19, w * 1.04, h * 0.19);
    catBodyPath.cubicTo(w * 1.04, h * 0.19, w * 1.02, h * 0.05, w * 1.02, h * 0.05);
    catBodyPath.cubicTo(w * 1.02, h * 0.05, w * 0.93, h * 0.12, w * 0.93, h * 0.12);
    catBodyPath.cubicTo(w * 0.89, h * 0.1, w * 0.82, h * 0.1, w * 0.82, h * 0.1);
    catBodyPath.cubicTo(w * 0.82, h * 0.1, w * 0.77, h * 0.1, w * 0.71, h * 0.12);
    catBodyPath.cubicTo(w * 0.71, h * 0.12, w * 0.63, h * 0.05, w * 0.63, h * 0.05);
    catBodyPath.cubicTo(w * 0.63, h * 0.05, w * 0.63, h * 0.05, w * 0.63, h * 0.05);
    Path catPath = Path()..addPath(catBodyPath, Offset(20.0, size.height - 300));
    return catPath;
  }
}
