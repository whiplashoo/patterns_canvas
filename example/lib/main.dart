import 'package:example/screens/screen1.dart';
import 'package:example/screens/screen2.dart';
import 'package:example/screens/screen3.dart';
import 'package:example/screens/screen4.dart';
import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      'screen1': (ctx) => Screen1(),
      'screen2': (ctx) => Screen2(),
      'screen3': (ctx) => Screen3(),
      'screen4': (ctx) => Screen4(),
    },
    home: Scaffold(
      body: MyExampleWidget(),
    ),
  ));
}

class MyExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(200, 200),
            painter: LogoPainter(),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'screen1');
            },
            child: Text('Painting patterns on canvas elements'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'screen2');
            },
            child: Text('Painting patterns on widgets'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'screen3');
            },
            child: Text('All patterns'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'screen4');
            },
            child: Text('Scaling settings'),
          ),
        ],
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Pattern bgPattern = HorizontalStripesThick(bgColor: Colors.white, fgColor: Color(0xffd1cccc));

    bgPattern.paintOnCircle(
        canvas, size, Offset(size.width * 0.4834907, size.height * 0.6769141), size.width * 0.5000000,
        patternScaleBehavior: PatternScaleBehavior.customRect, customRect: Rect.fromLTWH(0, 0, 500, 500));

    Path path1 = Path();
    path1.moveTo(size.width * 0.3707644, size.height * 0.3520804);
    path1.lineTo(size.width * 0.3707644, size.height * 0.3523300);
    path1.lineTo(size.width * 0.2963180, size.height * 0.3523300);
    path1.lineTo(size.width * 0.2963180, size.height * 1.00);
    path1.lineTo(size.width * 0.4148068, size.height * 1.00);
    path1.lineTo(size.width * 0.4148068, size.height * 0.7623690);
    path1.lineTo(size.width * 0.5403475, size.height * 0.7623690);
    path1.cubicTo(size.width * 0.6513337, size.height * 0.7243515, size.width * 0.7259126, size.height * 0.6756977,
        size.width * 0.7246095, size.height * 0.5542780);
    path1.cubicTo(size.width * 0.7250177, size.height * 0.4693757, size.width * 0.6913214, size.height * 0.3889142,
        size.width * 0.5489984, size.height * 0.3530257);
    path1.close();
    DiagonalStripesThick(bgColor: Color(0xff00154f), fgColor: Color(0xfff4af1b)).paintOnPath(canvas, size, path1,
        patternScaleBehavior: PatternScaleBehavior.customRect, customRect: Rect.fromLTWH(0, 0, 500, 500));

    Path path2 = Path();
    path2.moveTo(size.width * 0.4151616, size.height * 0.4686700);
    path2.lineTo(size.width * 0.4151616, size.height * 0.6457798);
    path2.lineTo(size.width * 0.5077888, size.height * 0.6457798);
    path2.cubicTo(size.width * 0.5684099, size.height * 0.6293687, size.width * 0.6091453, size.height * 0.6083660,
        size.width * 0.6084334, size.height * 0.5559528);
    path2.cubicTo(size.width * 0.6086554, size.height * 0.5193030, size.width * 0.5902515, size.height * 0.4845699,
        size.width * 0.5125140, size.height * 0.4690780);
    path2.lineTo(size.width * 0.4151616, size.height * 0.4686698);
    bgPattern.paintOnPath(canvas, size, path2,
        patternScaleBehavior: PatternScaleBehavior.customRect, customRect: Rect.fromLTWH(0, 0, 500, 500));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
