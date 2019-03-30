import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../screen/detail_screen.dart';
import '../screen/about_screen.dart';

// import '../constant/dummy.dart';
import '../utils/image_show_parser.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List data = [];

  Future fetchData() async {
    http.Response result = await http.get(
      'https://us-central1-fyuu-fyuu.cloudfunctions.net/schedule/',
      headers: {'Accept': 'application/json'},
    );

    this.setState(() {
      data = json.decode(result.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JKT48 Theater Schedule'),
        elevation: 0.0,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'JKT48 Theater\nSchedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return CardShow(index: index, data: data);
          },
        ),
      ),
    );
  }
}

class CardShow extends StatelessWidget {
  final int index;
  final List data;

  CardShow({this.index, this.data});

  @override
  Widget build(BuildContext context) {
    List reverseData = data.reversed.toList();
    double width = MediaQuery.of(context).size.width;
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
          children: <Widget>[
            Image.network(
              imageParser(reverseData[index]['title']),
              height: 140.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
            ),
            Container(
              height: 140.0,
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
                      Text(reverseData[index]['team']),
                      SizedBox(
                        width: 200,
                        child: Text(
                          '${reverseData[index]['title']}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Text(
                          '${reverseData[index]['showDay']} ${reverseData[index]['showDate']} - ${reverseData[index]['showTime']}WIB'),
                    ],
                  ),
                  Container(
                    width: width - 175,
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Lihat Detail',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
