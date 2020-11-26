import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'main.dart';

class load extends StatefulWidget {
  @override
  _loadState createState() => _loadState();
}

class _loadState extends State<load> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Color(0xffF9F7F4),
      image: Image.asset("assets/images/waiter.gif"),
      loaderColor: Color(0xffF9F7F4),
      photoSize: 150,
      navigateAfterSeconds: MyHomePage(title: 'TIPEX'),
    );
  }
}
