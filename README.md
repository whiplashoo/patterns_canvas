<p align="center"><img width="30%" src="https://user-images.githubusercontent.com/9117427/123286546-ad64e700-d516-11eb-92fe-ef6c3b459676.png"/></p>
<h1 align="center"> Patterns </h1>
<h2 align="center"> Flutter library to draw patterns like stripes or dots on Canvas elements or widgets. </h2>

# patterns_canvas  [![Pub Version](https://img.shields.io/pub/v/patterns_canvas?label=patterns_canvas&labelColor=333940&logo=dart)](https://pub.dev/packages/patterns_canvas)


### A utility library that lets you paint Canvas shapes or widgets with patterns like dots, stripes, squares, etc.:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286549-ad64e700-d516-11eb-8d0f-d9a8a8e37ecd.jpg"/>
  &nbsp; &nbsp;
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286554-adfd7d80-d516-11eb-9d1a-358c1b95d2d4.jpg"/>
  &nbsp; &nbsp;
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286556-af2eaa80-d516-11eb-8277-374035854ecb.jpg"/>
</p>

## Simple Example
Inside your `CustomPainter` class's `paint` method, create a `Pattern` class with background (`bgColor`) and foreground (`fgColor`) colors and use one of its `paintOn` methods:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  
    // Prepare a rectangle shape to draw the pattern on.
    final rect = Rect.fromLTWH(80, 50, 200, 100);
    
    // Create a Pattern object of diagonal stripes with the colors we want.
    final Pattern pattern = DiagonalStripesThick(bgColor: Colors.lightGreenAccent, fgColor: Colors.black);
    
    // Paint the pattern on the rectangle. 
    pattern.paintOnRect(canvas, size, rect);
    
  }
}
```
Results in this pattern drawn:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286559-afc74100-d516-11eb-8fba-3e8285d76a45.jpg"/>
</p>


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

3. From a String representation in the form of `patternType_backgroundHex_foregroundHex`:
```dart
final Pattern p3 = Pattern.fromString("diagonalLight_ffff00_000000");
```

## Usage
### Painting patterns on a `Canvas` shape:
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

Check the [Scale behavior setting](#scale-behavior-setting) section for more info on how the `Pattern` can be drawn.

### Painting patterns on the whole `Canvas`:
As above, but you can use the `paintOnCanvas` method to draw the pattern on the whole `Canvas`:

```dart
TexturePattern(bgColor: Colors.white, fgColor: Colors.blueGrey).paintOnCanvas(canvas, size);
```

The result of the above paints:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286564-b0f86e00-d516-11eb-86e8-8f02db35e036.jpg"/>
</p>

### Painting patterns on a Widget:
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

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286556-af2eaa80-d516-11eb-8277-374035854ecb.jpg"/>
</p>

Rectangular widgets, like Containers, Rows, Columns, IconButtons, etc. can be painted directly with the above method. For widgets that have a custom shape, like a `BottomAppbar`, you need to provide a different `clipBehavior` property, e.g. `Clip.antiAlias`, to make sure the pattern is clipped to the special shape. Check the second screen in the example app for more.



## Patterns and settings
### Available patterns
All Patterns require a background and foreground color on instantiation. The currently available patterns are:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286554-adfd7d80-d516-11eb-9d1a-358c1b95d2d4.jpg"/>
</p>

| Description        | Class           | PatternType enum  |
| ------------- |-------------| -----|
| Horizontal Stripes Light     | `HorizontalStripesLight(Color bgColor, Color fgColor)` | `PatternType.horizontalLight` |
| Horizontal Stripes Thick      | `HorizontalStripesThick(Color bgColor, Color fgColor)`      |   `PatternType.horizontalThick` |
| Vertical Stripes Light | `VerticalStripesLight(Color bgColor, Color fgColor)`      |    `PatternType.verticalLight` |
| Vertical Stripes Thick     | `VerticalStripesThick(Color bgColor, Color fgColor)` | `PatternType.verticalThick` |
| Diagonal Stripes Light      | `DiagonalStripesLight(Color bgColor, Color fgColor)`      |   `PatternType.diagonalLight` |
| Diagonal Stripes Thick | `DiagonalStripesThick(Color bgColor, Color fgColor)`      |    `PatternType.diagonalThick` |
| Checkers     | `Checkers(Color bgColor, Color fgColor)` | `PatternType.checkers` |
| Crosshatch      | `Crosshatch(Color bgColor, Color fgColor)`      |   `PatternType.crosshatch` |
| Dots | `Dots(Color bgColor, Color fgColor)`      |    `PatternType.dots` |
| Raindrops     | `Raindrops(Color bgColor, Color fgColor)` | `PatternType.raindrops` |
| Subtle Patch      | `SubtlePatch(Color bgColor, Color fgColor)`      |   `PatternType.subtlepatch` |
| Texture | `TexturePattern(Color bgColor, Color fgColor)`      |    `PatternType.texture` |

### Setting the number of pattern features to draw
You can pass a `featuresCount` argument when creating a Pattern, to set how many features, e.g. how many stripes, you want to be drawn.

```dart
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor, featuresCount: 40).paintOnRect(canvas, size, rect1);
Dots(bgColor: bgColor, fgColor: fgColor, featuresCount: 5).paintOnRect(canvas, size, rect2);
```

### Scale behavior setting
All patterns are **by default scaled to their container (`patternScaleBehavior = PatternScaleBehavior.container`)**. This means that, regardless of its size, a `Rectangle` will contain 15 diagonal stripes or 10 dots.

```dart
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1);
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2);
```

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/123286570-b1910480-d516-11eb-9985-e74c2303f672.jpg"/>
</p>

You can change this behavior by providing a different argument to the `paintOn` method:

Pass `patternScaleBehavior: PatternScaleBehavior.canvas` to **scale the pattern to the whole `Canvas` area**. Now the `Canvas` will contain 15 diagonal stripes or 10 dots, so, a `Rectangle` will contain as many dots or stripes as it can fit:

```dart
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.canvas);
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2, patternScaleBehavior: PatternScaleBehavior.canvas);
```

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/123286574-b1910480-d516-11eb-9a08-6da768645236.jpg"/>
</p>

Pass `patternScaleBehavior: PatternScaleBehavior.customRect` and a `customRect` (e.g. a `Rectangle` with half the `Canvas` height) to further customize the `Pattern` size:

```dart
final Rect halfCanvas = Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2); // a Rectangle with half the Canvas height.
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.customRect, customRect: halfCanvas );
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2, patternScaleBehavior: PatternScaleBehavior.customRect, customRect: halfCanvas );
```

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/123286529-aa69f680-d516-11eb-8f8f-366440416b13.jpg"/>
</p>
  
<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/123286536-ab028d00-d516-11eb-8463-b89adc84e5cc.jpg"/>
</p>
