import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constant/member.dart';
import '../utils/image_show_parser.dart';

class MemberDetailScreen extends StatefulWidget {
  final String name;
  MemberDetailScreen({this.name});

  @override
  _MemberDetailScreenState createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  Map biodata;
  bool ready = false;

  Future fetchData() async {
    http.Response result = await http.get(
      'https://us-central1-fyuu-fyuu.cloudfunctions.net/schedule/member?u=${memberList[widget.name]['url']}',
      headers: {'Accept': 'application/json'},
    );
    this.setState(() {
      biodata = json.decode(result.body);
      ready = true;
    });
  }

  Widget get _loadingView {
    return Container(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Map detail = memberList[widget.name];
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(detail['team'], style: TextStyle(fontSize: 14)),
            Text('Profil Member'),
          ],
        ),
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
      body: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  imageTeam(detail['team']),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  transform: Matrix4.translationValues(15.0, -50.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageMember(widget.name)),
                        backgroundColor: Colors.grey[400],
                        radius: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  transform: Matrix4.translationValues(0, -25.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          widget.name,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(detail['team'])),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Divider(height: 1),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      !ready
                          ? _loadingView
                          : Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Tanggal Lahir:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  subtitle: Text(
                                    '${biodata['birthdate']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                ListTile(
                                  title: Text(
                                    'Horoskop:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  subtitle: Text(
                                    '${biodata['horoscope']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                ListTile(
                                  title: Text(
                                    'Golongan Darah:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  subtitle: Text(
                                    '${biodata['bloodType']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                ListTile(
                                  title: Text(
                                    'Tinggi:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  subtitle: Text(
                                    '${biodata['height']}',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                                ListTile(
                                  title: Text(
                                    'Panggilan:',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  subtitle: Text(
                                    '${biodata['nickname']}',
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
