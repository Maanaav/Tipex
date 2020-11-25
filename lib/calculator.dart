import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:Tipex/globals.dart' as globals;

class calculator extends StatefulWidget {
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  var tip;
  final billController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // void changePass(BuildContext context, tip, myBill, totalBill) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CustomAlertDialog(
    //         content: Container(
    //           padding: EdgeInsets.all(20.0),
    //           width: MediaQuery.of(context).size.width / 1.2,
    //           height: MediaQuery.of(context).size.height / 4,
    //           color: Colors.white,
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                   child: Column(
    //                 children: <Widget>[
    //                   Row(
    //                     children: <Widget>[
    //                       Text("Bill: "),
    //                       Text(myBill.toString())
    //                     ],
    //                   ),
    //                   Row(
    //                     children: <Widget>[Text("Tip: "), Text(tip.toString())],
    //                   ),
    //                   Row(
    //                     children: <Widget>[
    //                       Text("Total: "),
    //                       Text(totalBill.toString())
    //                     ],
    //                   ),
    //                 ],
    //               )),
    //               // Container(
    //               //   margin: const EdgeInsets.only(top: 24.0),
    //               //   padding: EdgeInsets.all(5),
    //               //   child: Material(
    //               //     elevation: 5.0,
    //               //     borderRadius: BorderRadius.circular(25.0),
    //               //     color: Colors.white,
    //               //     child: MaterialButton(
    //               //       padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    //               //       child: Text(
    //               //         "Done",
    //               //         textAlign: TextAlign.center,
    //               //         style: TextStyle(
    //               //           fontSize: 17.0,
    //               //           fontWeight: FontWeight.bold,
    //               //         ),
    //               //       ),
    //               //       onPressed: () async {},
    //               //     ),
    //               //   ),
    //               // )
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    _showSnackBar() {
      final snackbar = SnackBar(content: Text("What's your bill amount?"), duration: Duration(seconds: 2),);

      _scaffoldKey.currentState.showSnackBar(snackbar);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Tipex",
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 23),
            ),
          ),
        ),
        flexibleSpace:
            Container(decoration: BoxDecoration(color: Colors.black)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffF3F4F9),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, .1),
                          blurRadius: 10,
                          offset: Offset(0, 5))
                    ]),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                        "Bill amount",
                        style: GoogleFonts.lato(
                            textStyle: TextStyle(fontSize: 18),
                            color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, .1),
                                      blurRadius: 10,
                                      offset: Offset(0, 2))
                                ]),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: billController,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 47,
                                      fontWeight: FontWeight.bold)),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              child: Text(
                                "₹",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 47,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3.5,
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Expanded(
                          child: SleekCircularSlider(
                            max: 100,
                            appearance: CircularSliderAppearance(
                                angleRange: 120,
                                customWidths:
                                    CustomSliderWidths(progressBarWidth: 30),
                                size: MediaQuery.of(context).size.width,
                                customColors: CustomSliderColors(
                                    trackColor: Colors.white,
                                    dotColor: Colors.white,
                                    progressBarColor: Colors.black,
                                    // progressBarColors: [
                                    //   Colors.green,
                                    //   Colors.yellow,
                                    //   Colors.red,
                                    // ],
                                    hideShadow: true)),
                            initialValue: 60,
                            onChange: (double value) {
                              setState(() {
                                //print(globals.yourRating);
                                globals.yourRating = value;
                              });

                              //print(value);
                            },
                            onChangeStart: (double startValue) {
                              //print(startValue);
                            },
                            onChangeEnd: (double endValue) {
                              // ucallback providing an ending value (when a pan gesture ends)
                            },
                            innerWidget: (double value) {
                              // use your custom widget inside the slider (gets a slider value from the callback)
                            },
                          ),
                        )),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2,
                    top: MediaQuery.of(context).size.height / 8,
                    child: Container(
                      child: globals.yourRating < 30
                          ? Image.asset("assets/images/Worst.png")
                          : globals.yourRating < 50
                              ? Image.asset("assets/images/Cry.png")
                              : globals.yourRating < 70
                                  ? Image.asset(
                                      "assets/images/Satisfactory.png")
                                  : Image.asset("assets/images/Love.png"),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 18,
                    top: MediaQuery.of(context).size.height / 130,
                    child: Container(
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Text("Your review",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(fontSize: 50),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black12)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 70,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              color: Colors.white,
                              child: Text(
                                'View amount',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (billController.text == "") {
                                  _showSnackBar();
                                } else {
                                  var myBill =
                                      double.parse(billController.text);
                                  var myReview = globals.yourRating * 0.05;
                                  print(myReview);
                                  print(globals.rating);

                                  var finalReview =
                                      (myReview + globals.rating) / 2;

                                  if (finalReview > 4) {
                                    tip = myBill * 0.2;
                                  } else if (finalReview < 4 &&
                                      finalReview > 3.5) {
                                    tip = myBill * 0.15;
                                  } else {
                                    tip = myBill * 0.1;
                                  }

                                  var totalBill = myBill + tip;

                                  print(tip);
                                  _onButtonPress(tip, myBill, totalBill);
                                  //changePass(context, tip, myBill, totalBill);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 70,
                              height: 70,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                  //side: BorderSide(color: Colors.black)
                                ),
                                color: Colors.black,
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            //   height: MediaQuery.of(context).size.height,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text("TIPEX", style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),)),
            //       Text("Calculate the tip amount of your bill", style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300), fontSize: 20)),
            //     ],
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     height: MediaQuery.of(context).size.height / 1.4,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(40),
            //           topRight: Radius.circular(40)),
            //       color: Color(0xff202125),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _onButtonPress(tip, myBill, totalBill) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.5,
            padding: EdgeInsets.all(20),
            //color: Colors.transparent,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "Total bill",
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 100),
                          fontSize: 30,
                          fontWeight: FontWeight.w900)),
                ),
                Text(
                  "₹" + totalBill.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w900)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Bill",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 100),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                  Text(
                                    myBill.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 3),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Tip",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 100),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900)),
                                  ),
                                  Text(
                                    tip.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
