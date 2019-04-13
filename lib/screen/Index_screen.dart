import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:package_info/package_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/models.dart';
import '../model/device_model.dart';
import '../action/device_action.dart';

import '../component/left_drawer.dart';

import '../constant/show.dart';
import '../constant/banner.dart';

import '../screen/show_more_screen.dart';

class IndexScreen extends StatefulWidget {
  final Store<AppState> store;
  IndexScreen({this.store});

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  List data = [];
  String version;
  String buildNumber;
  int current = 0;
  int currentBanner = 0;

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
    // var deviceName = widget.store.state.device.deviceName;
    // print('deviceName: $deviceName');
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

  List<Widget> promotion() {
    return [
      Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Promotion:',
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => ShowMoreScreen(
            //               data: data,
            //             ),
            //       ),
            //     );
            //   },
            //   child: Row(
            //     children: <Widget>[
            //       Text(
            //         'Lihat semua',
            //         style: TextStyle(fontSize: 14),
            //       ),
            //       Icon(Icons.chevron_right)
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      CarouselSlider(
        height: 150,
        viewportFraction: 0.62,
        aspectRatio: 2.0,
        // enlargeCenterPage: true,
        onPageChanged: (index) {
          setState(() {
            currentBanner = index;
          });
        },
        items: bannerPromotion.map((banner) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  _launchURL(banner['url']);
                },
                child: Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(children: <Widget>[
                      Image.network(banner['tinyImage'],
                          fit: BoxFit.cover, height: 150.0),
                    ]),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    ];
  }

  Widget body() {
    return Container(
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
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sedang Tampil:',
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
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
                padding: EdgeInsets.only(top: 15),
              ),
              CarouselSlider(
                height: 250,
                viewportFraction: 0.6,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(children: <Widget>[
                              Image.network(show['miniBanner'],
                                  fit: BoxFit.cover, height: 250.0),
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
                                      vertical: 10.0, horizontal: 20.0),
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                height: 90,
                child: Column(
                  children: <Widget>[
                    Text(
                      '${getTitle(current)}',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text('${getTeam(current)}'),
                  ],
                ),
              ),
              promotion()[0],
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              promotion()[1],
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel model) {
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
                  onRefresh: () => fetchData(),
                  child: body(),
                ),
        );
      },
    );
  }
}

class _ViewModel {
  Device device;
  Function(String) onSetDeviceName;

  _ViewModel({this.device, this.onSetDeviceName});

  factory _ViewModel.create(Store<AppState> store) {
    _onSetDeviceName(String deviceName) {
      store.dispatch(SetDeviceAction(deviceName: deviceName));
    }

    return _ViewModel(
      device: store.state.device,
      onSetDeviceName: _onSetDeviceName,
    );
  }
}

_launchURL(url) async {
  // const url = url;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
