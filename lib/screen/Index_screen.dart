import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../component/left_drawer.dart';
// import '../constant/dummy.dart';
import '../constant/show.dart';

import '../screen/show_more_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List data = [];
  String version;
  String buildNumber;
  int current = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> fetchData() async {
    http.Response result = await http.get(
      'https://us-central1-fyuu-fyuu.cloudfunctions.net/schedule/',
      headers: {'Accept': 'application/json'},
    );

    setState(() {
      data = json.decode(result.body);
    });
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('Schedule updated.')));
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
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  String getTeam(position) {
    return showList[position]['team'];
  }

  String getTitle(position) {
    return showList[position]['title'];
  }

  List filterData(show) {
    List result = [];
    data.forEach((eachData) {
      if (eachData['title'] == show['title']) result.add(eachData);
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      drawer: LeftDrawer(
        version: version,
        buildNumber: buildNumber,
      ),
      // body: data.length == 0 ? _loadingView : moreMenu(fetchData, data));
      body: data.length == 0
          ? _loadingView
          : RefreshIndicator(
              onRefresh: () {
                return fetchData();
              },
              child: Container(
                color: Colors.grey[200],
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Sedang Tampil:',
                                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShowMoreScreen(
                                            data: data,
                                          ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Lihat semua',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Icon(Icons.chevron_right)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        CarouselSlider(
                          height: 350,
                          viewportFraction: 0.8,
                          // aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index) {
                            setState(() {
                              current = index;
                            });
                          },
                          items: showList.map((show) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowMoreScreen(
                                              data: filterData(show),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(children: <Widget>[
                                        Image.network(show['miniBanner'],
                                            fit: BoxFit.cover, height: 350.0),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Text(
                                              'Beli Tiket',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Text(
                            '${getTitle(current)}',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text('${getTeam(current)}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
