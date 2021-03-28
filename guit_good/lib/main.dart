import 'package:flutter/material.dart';
import 'package:guit_good/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuitGood',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(title: 'GuitGood'),
    );
  }
}
