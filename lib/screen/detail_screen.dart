import 'package:flutter/material.dart';
import '../utils/image_show_parser.dart';

class DetailScreen extends StatelessWidget {
  final Map detail;
  DetailScreen({this.detail});

  List<Widget> _renderMember(member) {
    int length = member.length;
    List<Widget> list = List<Widget>();
    for (var i = 0; i < length; i++) {
      list.add(
        ListTile(
          leading: Icon(Icons.person),
          title: Text(member[i]),
        ),
      );
    }
    if (length == 0) {
      list.add(
        ListTile(
          title: Text('Tidak Ada Data'),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.red,
          elevation: 0.0,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.grey[200],
          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Image.network(
                        imageParser(detail['title']),
                        width: 150,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            detail['showDate'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${detail['showTime']}WIB',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${detail['exchange']}WIB',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: Colors.redAccent[700],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Text('Pesan Sekarang',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  ListTile(
                    title: Text('Team:'),
                    trailing: Text('${detail['team']}'),
                  ),
                  ListTile(
                    title: Text('Judul:'),
                    trailing: Text('${detail['title']}'),
                  ),
                  ListTile(
                    title: Text('Waktu Pertunjukan:'),
                    trailing: Text('${detail['showDate']}'),
                  ),
                  ListTile(
                    title: Text('Jam Pertunjukan:'),
                    trailing: Text('${detail['showTime']} WIB'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 10, 10, 10),
                    child: Text('Daftar Member Perform:',
                        style: TextStyle(fontSize: 16)),
                  ),
                  Wrap(children: _renderMember(detail['showMember'])),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                  // Text('Detail Pemesanan:', style: TextStyle(fontSize: 16)),
                  // Text(
                  //     'Pemesanan VIP: ${detail['order']['VIP']['start']} - ${detail['order']['VIP']['end']}'),
                  // Text(
                  //     'Pemesanan OFC: ${detail['order']['OFC']['start']} - ${detail['order']['OFC']['end']}'),
                  // Text(
                  //     'Pemesanan GENERAL: ${detail['order']['GENERAL']['start']} - ${detail['order']['GENERAL']['end']}'),
                ],
              ),
            ],
          ),
        ));
  }
}
