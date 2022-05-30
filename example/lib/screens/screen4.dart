import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scaling settings',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(double.infinity, double.infinity),
          isComplex: true,
          willChange: true,
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
    const horizontalPadding = 20.0;
    const verticalPadding = 22.0;
    const rectW = 150.0;
    const rectH = 75.0;
    var dx = horizontalPadding;
    var dy = verticalPadding;
    const fontColor = Colors.black87;
    const bgColor = Colors.indigo;
    const fgColor = Colors.yellow;
    TextPainter tp = TextPainter(
        textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    TextSpan span = TextSpan(
        style: TextStyle(color: fontColor),
        text: "• A pattern by default is scaled to its container:");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    span = TextSpan(
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: fontColor),
        text: "PatternScaleBehavior.container (default)");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor)
        .paintOnRect(canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH));
    dx += horizontalPadding + rectW;
    Dots(bgColor: bgColor, fgColor: fgColor)
        .paintOnRect(canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH));

    dx = horizontalPadding;
    dy += rectH + verticalPadding;
    span = TextSpan(
        style: TextStyle(color: fontColor),
        text: "• It can also scale to the whole canvas:");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    span = TextSpan(
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: fontColor),
        text: "PatternScaleBehavior.canvas");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(
        canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH),
        patternScaleBehavior: PatternScaleBehavior.canvas);
    dx += horizontalPadding + rectW;
    Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(
        canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH),
        patternScaleBehavior: PatternScaleBehavior.canvas);

    dx = horizontalPadding;
    dy += rectH + verticalPadding;
    span = TextSpan(
        style: TextStyle(color: fontColor),
        text: "• Or to a custom Rectangle that you provide:");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    span = TextSpan(
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: fontColor),
        text: "PatternScaleBehavior.customRect");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    span = TextSpan(
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: fontColor),
        text: "customRect: Rect.fromLTWH(0, height / 2, width, height/2)");
    tp.text = span;
    tp.layout();
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding;
    DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(
        canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH),
        patternScaleBehavior: PatternScaleBehavior.canvas);
    dx += horizontalPadding + rectW;
    Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(
        canvas, size, Rect.fromLTWH(dx, dy, rectW, rectH),
        patternScaleBehavior: PatternScaleBehavior.customRect,
        customRect:
            Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2));
    dx = horizontalPadding;
    dy += rectH + verticalPadding;
    span = TextSpan(
        style: TextStyle(color: fontColor),
        text:
            "• Or use the featuresCount property to explicitly set how many features are drawn for a pattern:");
    tp.text = span;
    tp.layout(maxWidth: size.width - 20);
    tp.paint(canvas, Offset(dx, dy));
    dy += verticalPadding * 2;
    span = TextSpan(
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w700, color: fontColor),
        text:
            "Pattern p = Dots(bgColor: Colors.green, fgColor: Colors.black, featuresCount: 5).paintOnPath(canvas, size, path);");
    tp.text = span;
    tp.layout(maxWidth: size.width - 20);
    tp.paint(canvas, Offset(dx, dy));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
