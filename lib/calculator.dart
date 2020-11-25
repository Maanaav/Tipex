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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Tip",
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 18),
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
                      child: globals.yourRating < 30 ? Image.asset("assets/images/Worst.png"): globals.yourRating < 50
                          ? Image.asset("assets/images/Cry.png")
                          : globals.yourRating < 70
                              ? Image.asset("assets/images/Satisfactory.png")
                              : Image.asset("assets/images/Love.png"),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 18,
                    top: MediaQuery.of(context).size.height / 130,
                    child: Container(
                      child: RotatedBox(quarterTurns: -1,child: Text("Your review", style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 50), fontWeight: FontWeight.bold, color: Colors.black12)))
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
}
