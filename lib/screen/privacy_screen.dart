import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://sites.google.com/view/privacy-policy-jkt48-schedule/",
      appBar: AppBar(
        title: Text("Privacy Policy"),
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
      initialChild: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
