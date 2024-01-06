import 'package:flutter/material.dart';
import 'package:project_manager/pages/home.dart';
import 'package:project_manager/storage/storage_manager.dart';

Future<void> main() async {
  final mainKey = GlobalKey();

  var file = StorageManager.get("text.json");
  if (file != null) {
    file["test"] = {};
    file["test"]["wow"] = "test";
    file["test"]["wow"] = "test again";
    file["test"]["wow2"] = "test";
    file["test2"]["wow"] = "test";
  }

  var mainApp = MaterialApp(
    key: mainKey,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  );

  runApp(mainApp);
}
