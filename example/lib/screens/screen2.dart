import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.deepPurple, Icons.call, 'CALL'),
          _buildButtonColumn(Colors.deepPurple, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(Colors.deepPurple, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = Expanded(
        child: CustomPaint(
            painter: TextContainerPatternPainter(),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Painting on a BottomAppBar ⬇️',
                    softWrap: true,
                  ),
                ),
              ),
            )));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Painting patterns on widgets',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          CustomPaint(
            painter: TopContainerPatternPainter(),
            child: Container(
              width: 600,
              height: 200,
              child: Center(
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Painting on a Container"),
                      ))),
            ),
          ),
          Center(
            child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Painting on Buttons"),
                )),
          ),
          buttonSection,
          textSection,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: CustomPaint(
            painter: BottomAppBarPatternPainter(),
            child: Row(
              children: <Widget>[
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  color: Colors.redAccent,
                  icon: const Icon(Icons.favorite),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildButtonColumn(Color color, IconData icon, String label) {
  return CustomPaint(
    painter: ButtonPatternPainter(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class TopContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    VerticalStripesThick(
            bgColor: Color(0xff0509050), fgColor: Color(0xfffdbf6f))
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ButtonPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Raindrops(bgColor: Color(0xffffffb3), fgColor: Color(0xffa6cee3))
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class TextContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Dots(bgColor: Color(0xffffffff), fgColor: Color(0xffd1e5f0))
        .paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BottomAppBarPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    DiagonalStripesLight(bgColor: Color(0xffeeeeee), fgColor: Color(0xffd1dbdd))
        .paintOnWidget(canvas, size,
            patternScaleBehavior: PatternScaleBehavior.canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
