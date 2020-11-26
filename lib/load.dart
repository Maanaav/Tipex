import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:splashscreen/splashscreen.dart';

import 'main.dart';

import 'package:Tipex/globals.dart' as globals;

class load extends StatefulWidget {
  @override
  _loadState createState() => _loadState();
}

class _loadState extends State<load> {
  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    globals.myLat = "${position.latitude}";
    globals.myLong = "${position.longitude}";
  }

  void initState() {
//     Future(() {
//    Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
// });
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'TIPEX')));
    });
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF9F7F4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/waiter.gif"),
        ],
      ),
      // seconds: 5,
      // backgroundColor: Color(0xffF9F7F4),
      // image: Image.asset("assets/images/waiter.gif"),
      // //loadingText: Text("Tipex"),
      // //title: Text("Tipex"),
      // loaderColor: Color(0xffF9F7F4),
      // photoSize: 150,
      // navigateAfterSeconds: MyHomePage(title: 'TIPEX'),
    );
  }
}
