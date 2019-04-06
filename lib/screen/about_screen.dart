import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../constant/member.dart';

class AboutScreen extends StatelessWidget {
  
  List<Widget> _renderMember(member, width) {
    int length = member.length;
    List<Widget> list = List<Widget>();
    var _list = member.values.toList();
    for (var i = 0; i < length; i++) {
      list.add(
        Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(_list[i]['image']),
            backgroundColor: Colors.grey[400],
            radius: width / 17,
          ),
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
        title: Text("About"),
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
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: Center(
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('List All Member:', style: Theme.of(context).textTheme.title,),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Wrap(
                        children: _renderMember(memberList, width),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10),),
                      Text('Perlu Diperhatikan:', style: Theme.of(context).textTheme.title,),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('• Show dan Member dapat berubah sewaktu waktu'),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('• Kami tidak berafiliasi dengan JKT48 atau AKS'),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('• Semua content bercopyright JKT48 dan AKS'),
                      Padding(padding: EdgeInsets.only(top: 5),),
                      Text('• Production 2019'),
                      Padding(padding: EdgeInsets.only(top: 5),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
