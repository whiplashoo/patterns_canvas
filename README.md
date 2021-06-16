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
Inside your `CustomPainter` class's `paint` method, instantiate a `Pattern` class with background (`bgColor`) and foreground (`fgColor`) colors and use one of its `paintOn` methods:

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
You can construct a Pattern with three different ways:

1. Directly with a `Pattern` type constructor:
````
final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
````

2. With the Pattern.fromValues factory constructor:
````
final Pattern p2 = Pattern.fromValues(patternType: PatternType.diagonalLight, bgColor: Colors.yellowAccent, fgColor: Colors.black);
````

3. From a String representation in the form of `pattern_backgroundHex_foregroundHex`:
````
final Pattern p3 = Pattern.fromString("diagonalLight_ffff00_000000");
````

````
pattern.paintOnCanvas(canvas, size);

pattern.paintOnWidget(canvas, size);
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

// 
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

The library exposes these methods for drawing with patterns:
```
pattern.paintOnPath(canvas, size, path);
pattern.paintOnRect(canvas, size, rect);
pattern.paintOnRRect(canvas, size, rRect);
pattern.paintOnCircle(canvas, size, center, radius);
```

Check the [Scale behavior setting](#scale-behavior-setting) section for more info on how the `Pattern` can be drawn.

### Painting patterns on the whole `Canvas`:
As above, but you can use the `paintOnCanvas` method to draw the pattern on the whole Canvas:

````
TexturePattern(bgColor: Colors.white, fgColor: Colors.blueGrey).paintOnCanvas(canvas, size);
````

The result of the above paints:

<p align="center">
<img width="30%" src="https://user-images.githubusercontent.com/9117427/122299889-3a9cb000-cf07-11eb-9ede-467b406bd3d9.jpg"/>
</p>

### Painting patterns on a Widget:



## Patterns and settings
### Available patterns
All Patterns require a background color and foreground color on instantiation. The currently available patterns are:

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
