import 'package:flutter/material.dart';
import 'package:guit_good/screens/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'services/database_service.dart';


void main() async {
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
