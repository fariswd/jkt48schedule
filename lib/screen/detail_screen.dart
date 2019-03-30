import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/image_show_parser.dart';
import '../constant/member.dart';

class DetailScreen extends StatelessWidget {
  final Map detail;
  DetailScreen({this.detail});

  List<Widget> _renderMember(member, width) {
    int length = member.length;
    List<Widget> list = List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(
        Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(memberList[member[i]]['image']),
            radius: width / 17,
          ),
        ),
      );
    }
    if (length == 0) {
      for (var i = 0; i < 16; i++) {
        list.add(
          Icon(
            Icons.person,
            size: width / 9,
            color: Colors.grey[500],
          ),
        );
      }
    }
    return list;
  }

  List<Widget> _renderMemberListTile(member, width) {
    int length = member.length;
    List<Widget> list = List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(memberList[member[i]]['image']),
          ),
          title: Text(member[i]),
        ),
      );
    }
    if (length == 0) {
      list.add(
        ListTile(
          leading: Icon(
            Icons.person,
            size: width / 9,
            color: Colors.grey[500],
          ),
          title: Text('Tidak ada data'),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(detail['team'], style: TextStyle(fontSize: 14)),
            Text(detail['title']),
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey[200],
        // padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  imageLargeParser(detail['title']),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  transform: Matrix4.translationValues(20.0, -40.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image.network(
                        imageTeam(detail['team']),
                        height: 100,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${detail['showDay']} ${detail['showDate']} - ${detail['showTime']}WIB',
                            style: TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                          ),
                          Text(
                            'Tukar Tiket: ${detail['exchangeTime']}WIB',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
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
                      Text(
                        'Daftar member:',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Wrap(
                        children: _renderMember(detail['showMember'], width),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Text(
                    'Detail Pertunjukan:',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Judul:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    '${detail['title']}',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Team:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    '${detail['team']}',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Waktu Pertunjukan:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    '${detail['showDay']} ${detail['showDate']} - ${detail['showTime']} WIB',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'Tukar Tiket:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    '${detail['exchangeTime']} WIB',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                ListTile(
                  leading: Text(
                    'List Member:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  trailing: Text(
                    '${detail['showMember'].length} orang',
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                Wrap(
                  children: _renderMemberListTile(detail['showMember'], width),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Theme.of(context).accentColor,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              _launchURL();
            },
            child: Center(
              child: Text(
                'BELI TIKET',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://jkt48.com/theater/schedule?lang=id';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
