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
}

