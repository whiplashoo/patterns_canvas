import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class Screen5 extends StatefulWidget {
  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test pad',
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
    TexturePattern(bgColor: Colors.white, fgColor: Colors.blueGrey)
        .paintOnCanvas(canvas, size);

    // Prepare a rectangle shape to draw the pattern on.
    final rect = Rect.fromLTWH(80, 50, 200, 100);

    // Create a Pattern object of diagonal stripes with the colors we want.
    final Pattern pattern = DiagonalStripesThick(
        bgColor: Colors.lightGreenAccent, fgColor: Colors.black);

    // Paint the pattern on the rectangle.
    pattern.paintOnRect(canvas, size, rect);

    final path = Path();
    path.moveTo(120, 200);
    path.lineTo(300, 280);
    path.quadraticBezierTo(20, 400, 40, 300);
    path.close();
    Crosshatch(bgColor: Colors.yellow, fgColor: Colors.black)
        .paintOnPath(canvas, size, path);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
