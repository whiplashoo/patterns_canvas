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
Inside your `CustomPainter` class's `paint` method, instantiate a Pattern class with background (`bgColor`) and foreground (`fgColor`) colors and use one of its `paintOn` methods:

```
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
  
    // Prepare a rectangle shape to draw the pattern on.
    final rect = Rect.fromLTWH(50, 50, 100, 50);
    
    // Create a Pattern object of diagonal stripes with the colors we want.
    final Pattern pattern = DiagonalStripesLight(bgColor: Colors.yellow, fgColor: Colors.black);
    
    // Paint the pattern on the rectangle. 
    pattern.paintOnRect(canvas, size, rect);
    
  }
}
```

## `Pattern` constructors and types:
You can construct a Pattern with three different ways:

1. Directly through a pattern type constructor:
````
final Pattern p1 = DiagonalStripesLight(bgColor: Colors.yellowAccent, fgColor: Colors.black);
````

## Usage
### Painting patterns on a `Canvas` shape:

### Painting patterns on a Widget:

### Painting patterns on the whole `Canvas`:

## Patterns and settings
### Available patterns:

### Scale behavior setting:
