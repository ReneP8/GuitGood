import 'package:flutter/material.dart';
import 'package:guit_good/screens/home.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Services/dbservice.dart';


void main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
      join(await getDatabasesPath(), 'guitGood.db'),
  );
  // Define a function that inserts dogs into the database
  Future<void> insertChallenge(Challenge challenge) async {
  // Get a reference to the database.
  final Database db = await database;
  await db.insert(
  'Challenges',
  challenge.toMap(),
  conflictAlgorithm: ConflictAlgorithm.replace,
  );
  }

// A method that retrieves all the dogs from the dogs table.
  Future<List<Challenge>> challenges() async {
      // Get a reference to the database.
      final Database db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('challenges');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Challenge(
        challengeID: maps[i]['challengeID'],
        difficulty: maps[i]['difficulty'],
        length: maps[i]['length'],
      );
    });
  }
  print(await challenges());
  print("Hallo");
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
