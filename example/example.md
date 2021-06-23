# Cookbook

All the snippets are from the [example project](https://github.com/whiplashoo/patterns_canvas/tree/main/example).

## Simple Usage
Inside your `CustomPainter` class's `paint` method, create a `Pattern` class with background (`bgColor`) and foreground (`fgColor`) colors and use one of its `paintOn` methods:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  
    // Prepare a rectangle shape to draw the pattern on.
    final rect = Rect.fromLTWH(80, 50, 200, 100);
    
    // Create a Pattern object of diagonal stripes with the colors we want.
    final Pattern pattern = DiagonalStripesLight(bgColor: Colors.lightGreenAccent, fgColor: Colors.black);
    
    // Paint the pattern on the rectangle. 
    pattern.paintOnRect(canvas, size, rect);
    
  }
}
```

## `Pattern` constructors and types:
You can construct a `Pattern` with three different ways:

1. Directly with a `Pattern` type constructor:
```dart
final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
```

2. With the `Pattern.fromValues` factory constructor:
```dart
final Pattern p2 = Pattern.fromValues(patternType: PatternType.diagonalLight, bgColor: Colors.yellowAccent, fgColor: Colors.black);
```

3. From a String representation in the form of `pattern_backgroundHex_foregroundHex`:
```dart
final Pattern p3 = Pattern.fromString("diagonalLight_ffff00_000000");
```

## Painting patterns on a `Canvas` shape:
- Create your `Canvas` element inside the `paint` function of your `CustomPaint`.
- Create a `Pattern` object with the desired type and colors.
- Use the corresponding paint method to draw the pattern on the object.

```dart
// In the build method of your screen:
...
body: Center(
    child: CustomPaint(
      size: const Size(double.infinity, double.infinity),
      painter: MyPainter(),
    ),
  ),
...

// In your CustomPainter:
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  
    final rect = Rect.fromLTWH(80, 50, 200, 100);
    DiagonalStripesLight(bgColor: Colors.lightGreenAccent, fgColor: Colors.black).paintOnRect(canvas, size, rect);
    
    final path = Path();
    path.moveTo(120, 200);
    path.lineTo(300, 280);
    path.quadraticBezierTo(20, 400, 40, 300);
    path.close();
    Crosshatch(bgColor: Colors.yellow, fgColor: Colors.black).paintOnPath(canvas, size, path);
    
  }
}
```

You can use the below methods to draw on `Canvas` shapes:
```dart
pattern.paintOnPath(canvas, size, path);
pattern.paintOnRect(canvas, size, rect);
pattern.paintOnRRect(canvas, size, rRect);
pattern.paintOnCircle(canvas, size, center, radius);
```

## Painting patterns on the whole `Canvas`:
As above, but you can use the `paintOnCanvas` method to draw the pattern on the whole `Canvas`:

```dart
TexturePattern(bgColor: Colors.white, fgColor: Colors.blueGrey).paintOnCanvas(canvas, size);
```

## Painting patterns on a Widget:
To draw patterns on a Widget, you need to:

- Wrap the Widget with a `CustomPaint`:
```dart
CustomPaint(
  painter: ContainerPatternPainter(),
  child: Container(
    width: 600,
    height: 200,
    child: Center(
      child: Text("Painting on a Container"),
    ),
  ),
),
```
- Inside your `CustomPainter`, create a `Pattern` and use its `paintOnWidget` method to paint with it:

```dart
class ContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    VerticalStripesThick(bgColor: Color(0xff0509050), fgColor: Color(0xfffdbf6f)).paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
```

