import 'package:flutter/material.dart';

import '../screen/detail_screen.dart';

import '../constant/dummy.dart';
import '../utils/image_show_parser.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('JKT48 Theater Schedule'),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: ListView.builder(
          itemCount: dummy.length,
          itemBuilder: (BuildContext context, int index) {
            return CardShow(index: index);
          },
        ),
      ),
    );
  }
}

class CardShow extends StatelessWidget {
  final int index;

  CardShow({this.index});

  final List reverseData = dummy.reversed.toList();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(detail: reverseData[index]),
          ),
        );
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.network(
              imageParser(reverseData[index]['title']),
              height: 130.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
            ),
            Container(
              height: 130.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      ),
                      Text(reverseData[index]['team'],
                          style: TextStyle(fontSize: 12.0)),
                      SizedBox(
                          width: 250,
                          child: Text(reverseData[index]['title'],
                              style: TextStyle(fontSize: 16.0))),
                      Text(
                          '${reverseData[index]['showDate']}, show: ${reverseData[index]['showTime']} WIB'),
                      Text(reverseData[index]['exchange']),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent[700],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text('Lihat Detail',
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
