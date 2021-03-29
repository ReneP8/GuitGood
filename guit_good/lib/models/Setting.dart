//not functional yet
class Setting {
  final int settingID;
  final int difficulty;
  final int length;

  Setting({this.settingID, this.difficulty, this.length});

  Map<String, dynamic> toMap() {
    return {
      'challengeID': settingID,
      'difficulty': difficulty,
      'length': length,
    };
  }
}

