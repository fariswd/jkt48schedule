import 'package:flutter/material.dart';
import './screen/index_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jkt48schedule',
      home: IndexScreen(),
    );
  }
}