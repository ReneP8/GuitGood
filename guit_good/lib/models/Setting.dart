//not functional yet
class Setting {
  int settingID;
  int difficulty;
  int length;

  Setting({this.settingID, this.difficulty, this.length});

  Map<String, dynamic> toMap() {
    return {
      'settingID': settingID,
      'difficulty': difficulty,
      'length': length,
    };
  }

  // from map to object
  factory Setting.fromMap(Map<String, dynamic> json) => new Setting(
    settingID: json["settingID"],
    difficulty: json["difficulty"],
    length: json["length"],
  );
}

