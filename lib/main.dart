
import 'package:flutter/material.dart';
import 'package:project_manager/Pages/home.dart';

Future<void> main() async {

  final mainKey = GlobalKey();

  var mainApp = MaterialApp(
    key: mainKey,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  );

  runApp(mainApp);
}


