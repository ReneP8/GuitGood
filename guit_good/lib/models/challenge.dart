class Challenge {
  final int challengeID;
  final int difficulty;
  final String content;
  final String category;

  Challenge({this.challengeID, this.difficulty, this.content, this.category});

  Map<String, dynamic> toMap() {
    return {
      'challengeID': challengeID,
      'difficulty': difficulty,
      'content' : content,
      'category': category
    };
  }

  // from map to object
  factory Challenge.fromMap(Map<String, dynamic> json) => new Challenge(
    challengeID: json["challengeID"],
    difficulty: json["difficulty"],
    content: json["content"],
    category: json["category"],
  );
}

