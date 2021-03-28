import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Challenge {
  final int challengeID;
  final int difficulty;
  final int length;

  Challenge({this.challengeID, this.difficulty, this.length});

  Map<String, dynamic> toMap() {
    return {
      'challengeID': challengeID,
      'difficulty': difficulty,
      'length': length,
    };
  }
}