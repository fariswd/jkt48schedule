import 'package:flutter/material.dart';

import '../component/card_show.dart';

class ShowMoreScreen extends StatelessWidget {
  final List data;
  ShowMoreScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail penampilan'),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5453A0),
                  Color(0xFFE46262),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
        ),
        body: data.length == 0
            ? Container(
              padding: EdgeInsets.all(15),
              child: Text('Tidak ada data'),
            )
            : Container(
                color: Colors.grey[200],
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardShow(index: index, data: data);
                  },
                ),
              ));
  }
}
