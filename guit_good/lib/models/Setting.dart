//not functional yet
class Setting {
  final int settingID;
  final int difficulty;
  final int length;

  Setting({this.settingID, this.difficulty, this.length});

  Map<String, dynamic> toMap() {
    return {
      'settingId': settingID,
      'difficulty': difficulty,
      'length': length,
    };
  }

  factory Setting.fromMap(Map<String, dynamic> json) => new Setting(
    settingID: json["settingId"],
    difficulty: json["difficulty"],
    length: json["length"],
  );
}

