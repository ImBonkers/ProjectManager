import 'dart:convert';
import 'dart:developer' as dev;
import 'package:project_manager/storage/file_manager.dart';

class InternalMap implements Map<dynamic, dynamic> {
  Map data = {};
  final Function save;

  InternalMap(Map map, this.save) {
    data = map;
    save();
  }

  @override
  operator [](Object? key) {
    if (!data.containsKey(key)) {
      data[key] = InternalMap({}, save);
      save();
    }
    return InternalMap(data[key], save);
  }

  @override
  void operator []=(key, value) {
    data[key] = value;
    save();
  }

  @override
  void addAll(Map other) {
    other.forEach((key, value) {
      data[key] = value;
    });
    save();
  }

  @override
  void addEntries(Iterable<MapEntry> newEntries) {
    for (var element in newEntries) {
      data[element.key] = element.value;
    }
    save();
  }

  @override
  Map<RK, RV> cast<RK, RV>() {
    return data.cast<RK, RV>();
  }

  @override
  void clear() {
    data = {};
    save();
  }

  @override
  bool containsKey(Object? key) {
    return data.containsKey(key);
  }

  @override
  bool containsValue(Object? value) {
    return data.containsValue(value);
  }

  @override
  Iterable<MapEntry> get entries => data.entries;

  @override
  void forEach(void Function(dynamic key, dynamic value) action) {
    data.forEach((key, value) {
      action(key, value);
    });
  }

  @override
  bool get isEmpty => data.isEmpty;

  @override
  bool get isNotEmpty => data.isNotEmpty;

  @override
  Iterable get keys => data.keys;

  @override
  int get length => data.length;

  @override
  Map<K2, V2> map<K2, V2>(
      MapEntry<K2, V2> Function(dynamic key, dynamic value) convert) {
    return data.map((key, value) {
      return convert(key, value);
    });
  }

  @override
  putIfAbsent(key, Function() ifAbsent) {
    data.putIfAbsent(key, ifAbsent);
    save();
  }

  @override
  remove(Object? key) {
    dynamic result = data.remove(key);
    save();
    return result;
  }

  @override
  void removeWhere(bool Function(dynamic key, dynamic value) test) {
    data.removeWhere(test);
    save();
  }

  @override
  update(key, Function(dynamic value) update, {Function()? ifAbsent}) {
    data.update(key, update, ifAbsent: ifAbsent);
    save();
  }

  @override
  void updateAll(Function(dynamic key, dynamic value) update) {
    data.updateAll(update);
    save();
  }

  @override
  Iterable get values => data.values;
}

class PersistentMap<K, V> {
  final String relFilepath;
  InternalMap? db;

  PersistentMap(this.relFilepath) {
    var fi = FileManager.openFile(relFilepath);
    if (fi == null) {
      return;
    }

    var content = fi.file.readAsStringSync();

    try {
      db = InternalMap(jsonDecode(content), save);
    } catch (e) {
      dev.log("Error decoding json $e");
      db = InternalMap({}, save);
    }
  }

  void save() {
    var fi = FileManager.openFile(relFilepath);
    if (fi == null) {
      return;
    }

    var content = jsonEncode(db);
    fi.file.writeAsStringSync(content);
  }

  void add(K key, V value) {
    if (db != null) {
      db![key] = value;
    }
  }

  dynamic remove(K key) {
    dynamic result;
    if (db != null) {
      result = db!.remove(key);
    }

    return result;
  }

  V? operator [](K key) {
    if (db != null) {
      return db?[key];
    }
    return null;
  }

  void operator []=(K key, V value) {
    if (db != null) {
      db?[key] = value;
    }
  }
}
