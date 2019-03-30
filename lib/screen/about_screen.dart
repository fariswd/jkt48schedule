import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.grey[200],
        child: GestureDetector(
          onTap: () {_launchURL();},
          child: Center(
            child: Text('https://github.com/fariswd/jkt48schedule'),
          ),
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