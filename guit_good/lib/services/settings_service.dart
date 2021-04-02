import 'package:guit_good/models/setting.dart';
import 'package:guit_good/providers/database_provider.dart';

class SettingsService {

  DatabaseProvider _databaseProvider = DatabaseProvider.db;

  Future<Setting> getSettings() async {
    final db = await _databaseProvider.database;
    var res = await db.query("Settings");
    Setting defaultSetting =
    res.isNotEmpty ? res.map((c) => Setting.fromMap(c)).toList().first : null;
    return defaultSetting;
  }

  Future<int> updateSetting(Setting setting) async {
    final db = await _databaseProvider.database;
    int res = await db.update("Settings", setting.toMap(), where: "settingID = ?", whereArgs: [setting.settingID]);
    return res;
  }
}
