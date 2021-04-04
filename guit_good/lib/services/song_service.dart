import 'package:guit_good/models/song.dart';
import 'package:guit_good/providers/database_provider.dart';

class SongService {
  DatabaseProvider _databaseProvider = DatabaseProvider.db;

  Future<Song> getRandomSong() async {
    final db = await _databaseProvider.database;
    var res =
    await db.rawQuery("SELECT * FROM Songs ORDER BY RANDOM() LIMIT 1");
    Song randomSong = res.isNotEmpty
        ? res.map((c) => Song.fromMap(c)).toList().first
        : null;
    return randomSong;
  }
}
