import 'package:flutter/material.dart';


import '../screen/about_screen.dart';
import '../screen/privacy_screen.dart';

class LeftDrawer extends StatelessWidget {
  final String version;
  final String buildNumber;
  LeftDrawer({this.version, this.buildNumber});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('ver. $version.build$buildNumber'),
            ),
            Divider(height: 1),
          ],
        ),
      );
  }
}