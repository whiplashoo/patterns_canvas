<p align="center"><img src="https://user-images.githubusercontent.com/9117427/122255264-a1ee3c00-ced6-11eb-9c5b-1563067d1188.png"/></p>
<h1 align="center"> Patterns </h1>
<h2 align="center"> Flutter library to draw patterns like stripes or dots on Canvas elements or widgets. </h2>

# patterns_canvas

### A utility library that lets you paint Canvas shapes or widgets with patterns like dots, stripes, squares, etc.:
<br/>
<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122257205-75d3ba80-ced8-11eb-8eae-ab98398437b8.jpg"/>
  &nbsp; &nbsp;
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122257217-78ceab00-ced8-11eb-8a83-267272c73c10.jpg"/>
  &nbsp; &nbsp;
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122257224-79ffd800-ced8-11eb-9411-913d9a33e97c.jpg"/>
</p>

## Simple Example
Inside your `CustomPainter` class's `paint` method, create a `Pattern` class with background (`bgColor`) and foreground (`fgColor`) colors and use one of its `paintOn` methods:

```
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
Results in this pattern drawn:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122299795-1fca3b80-cf07-11eb-8fc5-cc4223a4ac5e.jpg"/>
</p>


## `Pattern` constructors and types:
You can construct a `Pattern` with three different ways:

1. Directly with a `Pattern` type constructor:
````
final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
````

2. With the `Pattern.fromValues` factory constructor:
````
final Pattern p2 = Pattern.fromValues(patternType: PatternType.diagonalLight, bgColor: Colors.yellowAccent, fgColor: Colors.black);
````

3. From a String representation in the form of `pattern_backgroundHex_foregroundHex`:
````
final Pattern p3 = Pattern.fromString("diagonalLight_ffff00_000000");
````

## Usage
### Painting patterns on a `Canvas` shape:
- Create your `Canvas` element inside the `paint` function of your `CustomPaint`.
- Create a `Pattern` object with the desired type and colors.
- Use the corresponding paint method to draw the pattern on the object.

```
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
```
pattern.paintOnPath(canvas, size, path);
pattern.paintOnRect(canvas, size, rect);
pattern.paintOnRRect(canvas, size, rRect);
pattern.paintOnCircle(canvas, size, center, radius);
```

Check the [Scale behavior setting](#scale-behavior-setting) section for more info on how the `Pattern` can be drawn.

### Painting patterns on the whole `Canvas`:
As above, but you can use the `paintOnCanvas` method to draw the pattern on the whole `Canvas`:

````
TexturePattern(bgColor: Colors.white, fgColor: Colors.blueGrey).paintOnCanvas(canvas, size);
````

The result of the above paints:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122299889-3a9cb000-cf07-11eb-9ede-467b406bd3d9.jpg"/>
</p>

### Painting patterns on a Widget:
To draw patterns on a Widget, you need to:

- Wrap the Widget with a `CustomPaint`:
````
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
````
- Inside your `CustomPainter`, create a `Pattern` and use its `paintOnWidget` method to paint with it:

````
class ContainerPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    VerticalStripesThick(bgColor: Color(0xff0509050), fgColor: Color(0xfffdbf6f)).paintOnWidget(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
````

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122257224-79ffd800-ced8-11eb-9411-913d9a33e97c.jpg"/>
</p>

Rectangular widgets, like Containers, Rows, Columns, IconButtons, etc. can be painted directly with the above method. For widgets that have a custom shape, like a `BottomAppbar`, you need to provide a different `clipBehavior` property, e.g. `Clip.antiAlias`, to make sure the pattern is clipped to the special shape. Check the second screen in the example app for more.



## Patterns and settings
### Available patterns
All Patterns require a background and foreground color on instantiation. The currently available patterns are:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122257217-78ceab00-ced8-11eb-8a83-267272c73c10.jpg"/>
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


### Scale behavior setting
All patterns are **by default scaled to their container (`patternScaleBehavior = PatternScaleBehavior.container`)**. This means that, regardless of its size, a `Rectangle` will contain 40 diagonal stripes or 40 dots.

````
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1);
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2);
````

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/122351725-1963b000-cf57-11eb-993a-af64abb5e5da.png"/>
</p>

You can change this behavior by providing a different argument to the `paintOn` method:

Pass `patternScaleBehavior: PatternScaleBehavior.canvas` to **scale the pattern to the whole `Canvas` area**. Now the `Canvas` will contain 40 diagonal stripes or 40 dots, so, a `Rectangle` will contain as many dots or stripes as it can fit:

````
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.canvas);
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2, patternScaleBehavior: PatternScaleBehavior.canvas);
````

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/122351742-1f599100-cf57-11eb-858e-16a9de68b360.png"/>
</p>

Pass `patternScaleBehavior: PatternScaleBehavior.canvas` and a `customRect` (e.g. a `Rectangle` with half the `Canvas` height) to further customize the `Pattern` size:

````
final Rect halfCanvas = Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2); // a Rectangle with half the Canvas height.
DiagonalStripesThick(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect1, patternScaleBehavior: PatternScaleBehavior.customRect, customRect: halfCanvas );
Dots(bgColor: bgColor, fgColor: fgColor).paintOnRect(canvas, size, rect2, patternScaleBehavior: PatternScaleBehavior.customRect, customRect: halfCanvas );
````

<p align="center">
<img width="50%" src="https://user-images.githubusercontent.com/9117427/122351763-2385ae80-cf57-11eb-9193-946b0b10656c.png"/>
</p>
  
<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122357856-c42a9d00-cf5c-11eb-9578-a8f96f723ea1.jpg"/>
</p>

It is also in the Roadmap to allow for selecting the number of `Pattern` features to use (e.g. draw only 5 diagonal stripes).
