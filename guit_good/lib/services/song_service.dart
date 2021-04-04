import 'package:guit_good/models/song.dart';
import 'package:guit_good/providers/database_provider.dart';

class SongService {
  DatabaseProvider _databaseProvider = DatabaseProvider.db;

  Future<Song> getRandomSong(int difficulty, int length) async {
    final db = await _databaseProvider.database;
    var res = await db.rawQuery(
        "SELECT * FROM Songs AS S WHERE S.difficulty <= " +
            difficulty.toString() +
            " AND S.length <= " +
            length.toString() +
            " ORDER BY RANDOM() LIMIT 1");
    Song randomSong =
        res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList().first : null;
    return randomSong;
  }
}
