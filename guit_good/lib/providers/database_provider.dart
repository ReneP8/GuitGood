import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static Database _database;

  /*
  Returns _database if it exists and otherwise opens the database
   */
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  /*
  Tries to open the database. If there is no database it will create a new database.
  onCreate is not really needed, since we ship the database,
  but in case the database is (re)moved this will help a little
   */
  initDB() async {
    var dbDir = await getDatabasesPath();
    var dbPath = join(dbDir, "guitGood.db");

    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    ByteData data = await rootBundle.load("assets/guitGood.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(dbPath);
  }
}
