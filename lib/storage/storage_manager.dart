import 'package:project_manager/storage/file_map.dart';

class StorageManager {
  static Map<String, PersistentMap> db = {};

  static PersistentMap? load(String relFilepath) {
    if (!db.containsKey(relFilepath)) {
      db[relFilepath] = PersistentMap(relFilepath);
    }

    return db[relFilepath];
  }

  static void save(String relFilepath) {
    if (!db.containsKey(relFilepath)) {
      return;
    }

    db[relFilepath]!.save();
  }

  static PersistentMap? get(String relFilepath) {
    return load(relFilepath);
  }

  static bool add(String relFilepath, String key, dynamic value) {
    if (!db.containsKey(relFilepath)) {
      return false;
    }

    db[relFilepath]!.add(key, value);
    return true;
  }

  static bool remove(String relFilepath, String key) {
    if (!db.containsKey(relFilepath)) {
      return false;
    }

    db.remove(relFilepath);
    return true;
  }
}
