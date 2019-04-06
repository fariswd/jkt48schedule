import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screen/detail_screen.dart';
import '../screen/about_screen.dart';
import '../screen/privacy_screen.dart';

// import '../constant/dummy.dart';
import '../utils/image_show_parser.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List data = [];

  Future<void> fetchData() async {
    http.Response result = await http.get(
      'https://us-central1-fyuu-fyuu.cloudfunctions.net/schedule/',
      headers: {'Accept': 'application/json'},
    );

    setState(() {
      data = json.decode(result.body);
    });
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://oi64.tinypic.com/fyemow.jpg'),
                          backgroundColor: Colors.grey[400],
                        ),
                        Padding(padding: EdgeInsets.only(right: 3)),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://oi67.tinypic.com/atns4l.jpg'),
                          backgroundColor: Colors.grey[400],
                        ),
                        Padding(padding: EdgeInsets.only(right: 3)),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://oi64.tinypic.com/33vg749.jpg'),
                          backgroundColor: Colors.grey[400],
                        ),
                        Padding(padding: EdgeInsets.only(right: 3)),
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://oi64.tinypic.com/35l90go.jpg'),
                          backgroundColor: Colors.grey[400],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(
                      'JKT48 Theater Schedule',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5453A0),
                    Color(0xFFE46262),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Privacy Policy'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyScreen(),
                  ),
                );
              },
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.info),
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
            Divider(height: 1),
          ],
        ),
      ),
      body: data.length == 0
          ? _loadingView
          : RefreshIndicator(
            onRefresh: (){ return fetchData(); },
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardShow(index: index, data: data);
                },
              ),
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
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageParser(reverseData[index]['title']),
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
                        width: 190,
                        child: Text(
                          '${reverseData[index]['title']}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Text(
                          '${reverseData[index]['showDay']} ${reverseData[index]['showDate']}'),
                      Text('Show ${reverseData[index]['showTime']}WIB'),
                    ],
                  ),
                  Container(
                    width: width - 175,
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFdc4b50),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'SHOW DETAIL',
                          style: TextStyle(color: Colors.white, fontSize: 15),
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

_launchURL() async {
  const url = 'https://github.com/fariswd/jkt48schedule';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
