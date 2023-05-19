import 'dart:async';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:firstapp/LoginScreens/MainLoginPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainLoginPage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff009ffd),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: -25.0, end: -2026.0),
            Pin(size: 320.0, start: -117.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: const Color(0xf00652c5),
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0))),
            ),
          ),
          Pinned.fromPins(
            Pin(start: -3077.0, end: -25.0),
            Pin(size: 320.0, end: -150.0),
            child: Container(
              decoration: const BoxDecoration(
                color: const Color(0xf00652c5),
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 61.0, start: 20.0),
            Pin(size: 61.0, start: 49.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 200.0, middle: 0.5543),
            Pin(size: 51.0, start: 60.0),
            child: const Text(
              'Bus Tracker',
              style: TextStyle(
                fontFamily: 'Franklin Gothic',
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 22.0, end: 21.0),
            Pin(size: 349.0, middle: 0.5000),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/bus.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(600.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 45.0, end: 49.0),
            Pin(size: 36.0, middle: 0.7800),
            child: const Text(
              'We Are Here To Get You There',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 22,
                color: Colors.black,
              ),
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
