import 'package:path_provider/path_provider.dart';
import 'package:file_selector/file_selector.dart';
import 'dart:io';
import 'dart:developer' as dev;

class FileManager {
  static Future<String> get documentPath async {
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File?> getDocumentFile(String filepath,
      {bool createOnFailure = false}) async {
    var dir = await getApplicationDocumentsDirectory();
    var filePath = dir.path;
    var fullPath = "$filePath/$filepath";

    dev.log("File path: $fullPath");

    var file = File(fullPath);

    if (file.existsSync()) {
      return file;
    }

    if (!createOnFailure) {
      return null;
    }

    file.createSync(recursive: true);
    return file;
  }

  static Future<List<String>> getFilesInDirectory(String path) {
    return Directory(path).list().map((e) => e.path).toList();
  }

  static Future<List<String>> getFileNamesInDirectory(String path) {
    return Directory(path).list().map((e) => getFileName(e.path)).toList();
  }

  static String getFileName(String path) {
    return path.split("/").last;
  }

  static void pickFile() async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'images',
      extensions: <String>[],
    );
    final XFile? file = await openFile();
  }
}
