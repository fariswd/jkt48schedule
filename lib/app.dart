import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'model/models.dart';

import 'screen/Index_screen.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreBuilder(
        builder: (BuildContext context, Store<AppState> store) {
          return MaterialApp(
            title: 'JKT48 Theater Schedule',
            home: IndexScreen(store: store),
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
        },
      ),
    );
  }
}
