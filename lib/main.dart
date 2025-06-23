import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MoodShifterApp());
}

class MoodShifterApp extends StatelessWidget {
  const MoodShifterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodShifter Counter',
      home: MoodShifterHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MoodShifterHome extends StatefulWidget {
  const MoodShifterHome({super.key});

  @override
  State<MoodShifterHome> createState() => _MoodShifterHomeState();
}

class _MoodShifterHomeState extends State<MoodShifterHome> {
  int _counter = 0;
  Color _bgColor = Colors.white;
  final Random _random = Random();

  // Shape state (0 = circle, 1 = rounded box, 2 = square)
  int _shapeIndex = 0;

  final List<String> _emojis = ['😐', '🙂', '😄', '🤩', '🥳', '🔥'];

  String getEmoji(int count) {
    int index = (count ~/ 3) % _emojis.length;
    return _emojis[index];
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _bgColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
      _shapeIndex = (_shapeIndex + 1) % 3;
    });
  }

  BorderRadius _getShape(int shapeIndex) {
    switch (shapeIndex) {
      case 0:
        return BorderRadius.circular(100); // Circle
      case 1:
        return BorderRadius.circular(20); // Rounded box
      case 2:
      default:
        return BorderRadius.circular(0); // Square
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: Text('MoodShifter Counter'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: 150,
              height: 150,
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: _getShape(_shapeIndex),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(getEmoji(_counter), style: TextStyle(fontSize: 60)),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Count: $_counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Tap Me!'),
            ),
          ],
        ),
      ),
    );
  }
}
