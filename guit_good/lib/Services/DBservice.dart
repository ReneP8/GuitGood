import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBservice {
  DBservice._();
  static final DBservice db = DBservice._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'guitGood.db').toString(),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE "Challenges" (
        "challengeID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
        "difficulty"	INTEGER NOT NULL DEFAULT 3,
        "content"	TEXT NOT NULL,
        "category"	TEXT NOT NULL DEFAULT 'random'
        );''');
        await db.execute('''
        CREATE TABLE "Settings" (
          "settingID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
          "difficulty"	INTEGER NOT NULL DEFAULT 3 CHECK(difficulty>0 and difficulty<=10),
          "length"	INTEGER NOT NULL DEFAULT 3 CHECK(difficulty>0 and difficulty<=10)
        );''');
        await db.execute('''
        CREATE TABLE "Songs" (
          "songID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
          "name"	TEXT NOT NULL,
          "difficulty"	INTEGER DEFAULT 3 CHECK(difficulty>0 and difficulty<=10),
          "length"	INTEGER CHECK(length>0 and length<=10),
          "artist"	TEXT DEFAULT 'unknown',
          "genre"	INTEGER NOT NULL DEFAULT 'random',
          "url"	TEXT CHECK(SUBSTR(url,1,8)='https://')
        );''');
      }
    );
  }
}


