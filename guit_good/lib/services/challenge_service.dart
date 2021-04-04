import 'package:guit_good/models/challenge.dart';
import 'package:guit_good/providers/database_provider.dart';

class ChallengeService {
  DatabaseProvider _databaseProvider = DatabaseProvider.db;

  Future<Challenge> getRandomChallenge() async {
    final db = await _databaseProvider.database;
    var res =
        await db.rawQuery("SELECT * FROM Challenges ORDER BY RANDOM() LIMIT 1");
    Challenge randomChallenge = res.isNotEmpty
        ? res.map((c) => Challenge.fromMap(c)).toList().first
        : null;
    return randomChallenge;
  }
}
