import 'package:flutter/material.dart';
import '../screen/detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/image_show_parser.dart';

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
