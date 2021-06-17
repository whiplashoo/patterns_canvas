/// A utility library that lets you paint Canvas shapes or widgets with patterns like dots, stripes, squares, etc.:
/// ## Simple Example
/// Inside your `CustomPainter` class's `paint` method, create a `Pattern` class with background (`bgColor`) and
/// foreground (`fgColor`) colors and use one of its `paintOn` methods:

///```dart
/// class MyPainter extends CustomPainter {
///   @override
///   void paint(Canvas canvas, Size size) {
///
///     // Prepare a rectangle shape to draw the pattern on.
///     final rect = Rect.fromLTWH(80, 50, 200, 100);
///
///     // Create a Pattern object of diagonal stripes with the colors we want.
///     final Pattern pattern = DiagonalStripesLight(bgColor: Colors.lightGreenAccent, fgColor: Colors.black);
///
///     // Paint the pattern on the rectangle.
///     pattern.paintOnRect(canvas, size, rect);
///
///   }
/// }
///```
library patterns_canvas;

export 'src/pattern.dart';
export 'src/patterns/checkers.dart';
export 'src/patterns/crosshatch.dart';
export 'src/patterns/diagonal_stripes_light.dart';
export 'src/patterns/diagonal_stripes_thick.dart';
export 'src/patterns/dots.dart';
export 'src/patterns/horizontal_stripes_light.dart';
export 'src/patterns/horizontal_stripes_thick.dart';
export 'src/patterns/raindrops.dart';
export 'src/patterns/subtle_patch.dart';
export 'src/patterns/texture.dart';
export 'src/patterns/vertical_stripes_light.dart';
export 'src/patterns/vertical_stripes_thick.dart';
