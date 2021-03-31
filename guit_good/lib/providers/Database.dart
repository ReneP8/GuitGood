import 'dart:io';

import 'package:flutter/services.dart';
import 'package:guit_good/models/Setting.dart';
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
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    return await openDatabase(dbPath);
    // return await openDatabase(dbPath, onCreate: (db, version) async {
    //   await db.execute('''
    //     CREATE TABLE "Challenges" (
    //     "challengeID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    //     "difficulty"	INTEGER NOT NULL DEFAULT 3,
    //     "content"	TEXT NOT NULL,
    //     "category"	TEXT NOT NULL DEFAULT 'random'
    //     );''');
    //   await db.execute('''
    //     CREATE TABLE "Settings" (
    //       "settingID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    //       "difficulty"	INTEGER NOT NULL DEFAULT 3 CHECK(difficulty>0 and difficulty<=10),
    //       "length"	INTEGER NOT NULL DEFAULT 3 CHECK(difficulty>0 and difficulty<=10)
    //     );''');
    //   await db.execute('''
    //     CREATE TABLE "Songs" (
    //       "songID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
    //       "name"	TEXT NOT NULL,
    //       "difficulty"	INTEGER DEFAULT 3 CHECK(difficulty>0 and difficulty<=10),
    //       "length"	INTEGER CHECK(length>0 and length<=10),
    //       "artist"	TEXT DEFAULT 'unknown',
    //       "genre"	INTEGER NOT NULL DEFAULT 'random',
    //       "url"	TEXT CHECK(SUBSTR(url,1,8)='https://')
    //     );''');
    // }, version: 1);
  }

  Future<Setting> getSettings() async {
    final db = await database;
    var res = await db.query("Settings");
    Setting defaultSetting =
    res.isNotEmpty ? res.map((c) => Setting.fromMap(c)).toList().first : null;
    return defaultSetting;
  }

  Future<int> updateSetting(Setting setting) async {
    final db = await database;
    int res = await db.update("Settings", setting.toMap(), where: "settingID = ?", whereArgs: [setting.settingID]);
    return res;
  }
}
