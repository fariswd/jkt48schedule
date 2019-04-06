import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/image_show_parser.dart';
import '../constant/member.dart';
import '../screen/member_detail_screen.dart';

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
            backgroundImage: NetworkImage(imageMember(member[i])),
            backgroundColor: Colors.grey[400],
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
            size: width / 9 + 1.8,
            color: Colors.grey[500],
          ),
        );
      }
    }
    return list;
  }

  List<Widget> _renderMemberListTile(member, width, context) {
    int length = member.length;
    List<Widget> list = List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageMember(member[i])),
            backgroundColor: Colors.grey[400],
          ),
          trailing: Icon(Icons.chevron_right),
          title: Text(member[i]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => MemberDetailScreen(name: member[i])
            ));
          },
        ),
      );
      list.add(Divider(height: 1));
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
                  imageLargeParser(detail['title']),
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
                Container(
                  transform: Matrix4.translationValues(15.0, -40.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: imageTeam(detail['team']),
                        height: 100.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${detail['showDay']} ${detail['showDate']} - ${detail['showTime']}WIB',
                            style: TextStyle(fontSize: 17),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                          ),
                          Text(
                            'Tukar Tiket: ${detail['exchangeTime']}WIB',
                            style: TextStyle(fontSize: 17),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
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
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Daftar member:',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Divider(height: 1),
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
                  padding: EdgeInsets.fromLTRB(15, 0, 8, 5),
                  child: Text(
                    'Detail Pertunjukan:',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Judul:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: Text(
                    '${detail['title']}',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Team:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: Text(
                    '${detail['team']}',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Waktu:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: Text(
                    '${detail['showDay']} ${detail['showDate']} - ${detail['showTime']} WIB',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'Tukar Tiket:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: Text(
                    '${detail['exchangeTime']} WIB',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  title: Text(
                    'List Member:',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: Text(
                    '${detail['showMember'].length} orang',
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 8, 5),
                  child: Text(
                    'Detail Member:',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Divider(height: 1),
                Wrap(
                  children: _renderMemberListTile(detail['showMember'], width, context),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Color(0xFFdc4b50),
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
