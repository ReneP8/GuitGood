import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:guit_good/models/Challenge.dart';

/*
This service provides access to our database.
 */
class DBservice {
  DBservice._();
  static final DBservice db = DBservice._();
  static Database _database;

  /*
  Returns _database if it exists and otherwise opens the database
   */
  Future<Database> get database async {
    if(_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  /*
  Tries to open the database. If there is no database it will create a new database.
  onCreate is not really needed, since we ship the database,
  but in case the database is (re)moved this will help a little
   */
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
      },
      version: 1
    );
  }

  /*
    Creates a new Challenge
    param: newChallenge is challenge that is to be inserted
   */
  newChallenge(newChallenge) async {
    //creates a
    final db = await database;

    var res = await db.rawInsert('''
     INSERT INTO challenges (
      challengeID, difficulty, content, category
     ) VALUES (?, ?, ?, ?)
    ''', [newChallenge.challengeID, newChallenge.difficulty,
        newChallenge.content, newChallenge.category]);
    return res;
  }

  /*
    Returns a challenge; this is just for testing
   */
  Future<dynamic> getChallenge() async {
    final db = await database;
    var res = await db.query("challenge");
    if(res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : null;
    }
  }
}


