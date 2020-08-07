import 'package:flutter/material.dart';
import 'views/bmi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMIPage(),
    );
  }
}
