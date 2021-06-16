import 'package:example/screens/screen1.dart';
import 'package:example/screens/screen2.dart';
import 'package:example/screens/screen3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      'screen1': (ctx) => Screen1(),
      'screen2': (ctx) => Screen2(),
      'screen3': (ctx) => Screen3(),
      // 'screen4': (ctx) => Screen4(),
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
