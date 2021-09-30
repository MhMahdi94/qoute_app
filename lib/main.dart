import 'package:flutter/material.dart';
import 'package:qoute_app_1/qoutePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QoutePage());
  }
}
