import 'package:flutter/material.dart';
import './screen/index_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JKT48 Theater Schedule',
      home: IndexScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFFdc4b50),
        accentColor: Colors.redAccent[700],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          title: TextStyle(fontSize: 18.0),
          body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}
