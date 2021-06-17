import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All patterns',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          painter: MyPainter(context),
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
    final List<Pattern> patternsList = [
      HorizontalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black),
      HorizontalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black),
      VerticalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black),
      VerticalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black),
      DiagonalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black),
      DiagonalStripesThick(bgColor: Colors.yellow, fgColor: Colors.black),
      Checkers(bgColor: Colors.yellow, fgColor: Colors.black),
      Crosshatch(bgColor: Colors.yellow, fgColor: Colors.black),
      Dots(bgColor: Colors.yellow, fgColor: Colors.black),
      Raindrops(bgColor: Colors.yellow, fgColor: Colors.black),
      SubtlePatch(bgColor: Colors.yellow, fgColor: Colors.black),
      TexturePattern(bgColor: Colors.yellow, fgColor: Colors.black),
    ];

    const horizontalPadding = 20.0;
    const verticalPadding = 30.0;
    final rectW = (size.width - horizontalPadding * 3) / 2;
    final rectH = (size.height - verticalPadding * 7) / 6;
    var dx = horizontalPadding;
    var dy = verticalPadding;
    TextPainter tp = TextPainter(textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    for (var i = 0; i < 6; i++) {
      final Pattern p = patternsList[i];
      TextSpan span = TextSpan(style: TextStyle(color: Colors.grey[900]), text: p.description);
      tp.text = span;
      tp.layout();
      tp.paint(canvas, Offset(dx, dy - 20));

      final rect = Rect.fromLTWH(dx, dy, rectW, rectH);
      p.paintOnRect(canvas, size, rect, patternScaleBehavior: PatternScaleBehavior.canvas);
      dy += verticalPadding + rectH;
    }
    dx += horizontalPadding + rectW;
    dy = verticalPadding;
    for (var i = 6; i < 12; i++) {
      final Pattern p = patternsList[i];
      TextSpan span = TextSpan(style: TextStyle(color: Colors.grey[900]), text: p.description);
      tp.text = span;
      tp.layout();
      tp.paint(canvas, Offset(dx, dy - 20));

      final rect = Rect.fromLTWH(dx, dy, rectW, rectH);
      p.paintOnRect(canvas, size, rect, patternScaleBehavior: PatternScaleBehavior.canvas);
      dy += verticalPadding + rectH;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
