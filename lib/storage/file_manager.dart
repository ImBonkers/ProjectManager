import 'dart:io';
import 'dart:developer' as dev;

class FileInfo {
  FileInfo(this.file, this.lastUpdate, this.open, {this.handle});
  File file;
  DateTime lastUpdate;
  bool open;
  RandomAccessFile? handle;
}

class FileManager {
  static Map<String, FileInfo> activeFiles = {};

  static Directory getRootDirectory() {
    return Directory(Platform.resolvedExecutable).parent;
  }

  static FileInfo? openFile(String filepath) {
    var root = getRootDirectory();
    var absPath = "${root.path}/$filepath";

    if (activeFiles.containsKey(absPath)) {
      dev.log("File already open $absPath");
      return activeFiles[absPath]!;
    }

    var file = File(absPath);
    var exists = file.existsSync();

    if (!exists) {
      file.createSync(recursive: true);
      dev.log("File created $absPath");
    } else {
      dev.log("File found $absPath");
    }

    var lastUpdate = file.lastModifiedSync();
    var duration = DateTime.now().difference(lastUpdate).inMilliseconds;

    var openedFile = file.openSync(mode: FileMode.write);
    var fi = FileInfo(file, lastUpdate, true, handle: openedFile);

    activeFiles[absPath] = fi;

    return fi;
  }

  static void closeFile(String filepath) {
    var root = getRootDirectory();
    var absPath = "${root.path}/$filepath";

    if (activeFiles.containsKey(absPath)) {
      var fi = activeFiles[absPath]!;
      fi.handle!.closeSync();
      fi.open = false;
      activeFiles.remove(absPath);
    }
  }

  static bool writeToFile(String filepath, String data) {
    var fi = openFile(filepath);

    if (fi == null) {
      dev.log("File not found $filepath");
      return false;
    }

    fi.file.writeAsStringSync(data);
    return true;
  }
}
