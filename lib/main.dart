import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() async {
  await DotEnv().load(".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'TIPEX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final dio = Dio(BaseOptions(
      baseUrl: "https://developers.zomato.com/api/v2.1/search",
      headers: {
        "user-key": DotEnv().env["ZOMATO_API_KEY"],
      }));

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();

  List _restaurants;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 3.5);

  GoogleMapController _mapController;

  Location _location = Location();

  void _onMapcreated(GoogleMapController _ctrl) {
    changeMapMode();
    _mapController = _ctrl;
    _location.onLocationChanged.listen((event) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude, event.longitude), zoom: 19)));
    });
  }

  changeMapMode() {
    getJsonFile("assets/dark.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _mapController.setMapStyle(mapStyle);
  }

  void searchRes(String res) async {
    double lat = 19.1636;
    double long = 72.8459;
    final response = await widget.dio.get(
        "https://developers.zomato.com/api/v2.1/search",
        queryParameters: {"q": res, "lat": lat, "lon": long});
    setState(() {
      _restaurants = response.data["restaurants"];
    });
  }

  void initState() {
    searchRes("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.1,
            child: AbsorbPointer(
              absorbing: true,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                onMapCreated: _onMapcreated,
                myLocationEnabled: true,
                onTap: (cordinate) {
                  _mapController
                      .animateCamera(CameraUpdate.newLatLng(cordinate));
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height / 1.7,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      "Location",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .1),
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ]),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        searchRes(searchController.text);
                      },
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.my_location),
                          hintText: "Where you eating at?",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none),
                    ),
                  ),
                  _restaurants != null
                      ? Expanded(
                          child: ListView(
                            children: _restaurants.map((res) {
                              var star =
                                  "${res["restaurant"]["user_rating"]["aggregate_rating"]}";
                              return ListTile(
                                title: Text(res["restaurant"]["name"]),
                                subtitle: Text(
                                    res["restaurant"]["location"]["address"]),
                                trailing: Text(
                                    "${res["restaurant"]["user_rating"]["aggregate_rating"]} staars"),
                              );
                            }).toList(),
                          ),
                        )
                      : Text(""),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
