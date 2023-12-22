import 'dart:io';
import 'dart:developer' as dev;

class StorageManager {
  static Directory getRootDirectory() {
    return Directory(Platform.resolvedExecutable).parent;
  }

  static void loadFile(String filepath) {
    var root = getRootDirectory();
    var file = File("${root.path}\\$filepath");
    file.open(mode: FileMode.append).then((value) {
      value.writeString("Hello World");
      dev.log("File opened");
    });
  }
}
