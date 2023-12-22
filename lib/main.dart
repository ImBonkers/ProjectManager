import 'package:flutter/material.dart';
import 'package:project_manager/pages/home.dart';
import 'package:project_manager/Search/search_tag_bar.dart';
import 'package:project_manager/storage/storage_manager.dart';

import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

Future<void> main() async {
  final mainKey = GlobalKey();

  StorageManager.loadFile("test.txt");

  var mainApp = MaterialApp(
    key: mainKey,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  );

  runApp(mainApp);
}
