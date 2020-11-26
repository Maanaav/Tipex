import 'dart:ffi';

import 'package:Tipex/calculator.dart';
import 'package:Tipex/load.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:Tipex/globals.dart' as globals;
import 'package:splashscreen/splashscreen.dart';

void main() async {
  await DotEnv().load(".env");
  runApp(MyApp());
}

const int _blackPrimaryValue = 0xFF000000;

class MyApp extends StatelessWidget {
  static Map<int, Color> color = {
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  };
  MaterialColor primeColor = MaterialColor(0xFF2B2A30, color);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor: Colors.black,
        primarySwatch: primeColor,
        canvasColor: Colors.transparent,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: load(),
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

  String myLat, myLon;

  bool containerUp = false;

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
    final response = await widget.dio.get(
        "https://developers.zomato.com/api/v2.1/search",
        queryParameters: {"q": res, "lat": myLat, "lon": myLon});
    setState(() {
      _restaurants = response.data["restaurants"];
    });
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    myLat = "${position.latitude}";
    myLon = "${position.longitude}";
  }

  void initState() {
    _getCurrentLocation();
    searchRes("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String star;
    var heightContainer = MediaQuery.of(context).size.height / 1.7;
    var alignContainer = Alignment.bottomCenter;

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
          //           Container(
          //   height: 500,
          //   alignment: Alignment.center,
          //   child: IconButton(
          //       icon: containerUp
          //           ? Icon(Icons.arrow_circle_down_rounded)
          //           : Icon(Icons.arrow_circle_up_rounded),
          //       onPressed: () {
          //         setState(() {
          //           // containerUp
          //           //     ? containerUp = false
          //           //     : containerUp = true;
          //           if (containerUp == false) {
          //             print("object");
          //             containerUp = true;
          //             heightContainer = MediaQuery.of(context).size.height;
          //             alignContainer = Alignment.topCenter;
          //           } else {
          //             containerUp = false;
          //             heightContainer =
          //                 MediaQuery.of(context).size.height / 1.7;
          //             alignContainer = Alignment.bottomCenter;
          //           }
          //         });
          //       }),
          // ),
          Align(
            alignment: alignContainer,
            child: Container(
              //padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: heightContainer,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      "Location",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w900)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
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
                  ),
                  _restaurants != null
                      ? Expanded(
                          child: ListView(
                            children: _restaurants.map((res) {
                              return GestureDetector(
                                onTap: () {
                                  //print(res["restaurant"]["featured_image"]);
                                  star =
                                      "${res["restaurant"]["user_rating"]["aggregate_rating"]}";
                                  var finalRatings = double.parse(star);
                                  globals.rating = finalRatings;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => calculator()));
                                  searchController.clear();
                                  searchRes(searchController.text);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    leading: res["restaurant"]
                                                ["featured_image"] !=
                                            ""
                                        ? CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: NetworkImage(
                                                res["restaurant"]
                                                    ["featured_image"]),
                                            backgroundColor: Colors.transparent,
                                          )
                                        : CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage: AssetImage(
                                                "assets/images/load.png"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                    // leading: Image.network(res["restaurant"]["featured_image"]),
                                    title: Text(
                                      res["restaurant"]["name"],
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    subtitle: Text(
                                      res["restaurant"]["location"]["address"],
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    // trailing: Text(
                                    //     "${res["restaurant"]["user_rating"]["aggregate_rating"]} stars"),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: FractionalOffset.center,
                                child: Container(
                                  width: 70.0,
                                  height: 70.0,
                                  child: SpinKitDoubleBounce(
                                    color: Colors.indigo,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
