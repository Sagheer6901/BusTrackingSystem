import 'dart:async';

import 'package:firstapp/ButtonsfordriverDashboard/StartingpointEndingpointMap/TrackingButton.dart';
import 'package:firstapp/ButtonsfordriverDashboard/emergencybtn.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:firstapp/LoginScreens/LoginScreenDriver.dart';
import 'package:firstapp/LoginScreens/MainLoginPage.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

import '../ButtonsfordriverDashboard/LiveLocation/LiveTracking.dart';

const int SESSION_TIMEOUT = 5; //
//const int SESSION_TIMEOUT = 5 * 60; // 5 minutes in seconds 5 minutes in seconds

class MainScreenForDriver extends StatefulWidget {
  const MainScreenForDriver({super.key});
  @override
  State<MainScreenForDriver> createState() => _MainScreenForDriverState();
}

class _MainScreenForDriverState extends State<MainScreenForDriver> {
  Timer? _sessionTimer;

  void _startSessionTimer() {
    // Cancel any existing timer before starting a new one
    _cancelSessionTimer();

    // Start a new session timer
    _sessionTimer = Timer(const Duration(seconds: SESSION_TIMEOUT), () {
      // Session has timed out, navigate to login page
      Navigator.pushReplacementNamed(context, '/Main_Login_Page');
    });
  }

  void _cancelSessionTimer() {
    if (_sessionTimer != null) {
      _sessionTimer!.cancel();
      _sessionTimer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
  }

  @override
  void dispose() {
    _cancelSessionTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: _startSessionTimer,
          ),
          Pinned.fromPins(
            Pin(size: 187.0, start: 45.0),
            Pin(size: 80.0, start: 65.0),
            child: const Text(
              '   DRIVER\n DASHBOARD',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30,
                color: Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 100.0, end: 29.0),
            Pin(size: 100.0, start: 50.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/driverdashboard.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(113.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 15.0),
            Pin(size: 51.0, middle: 0.2462),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 154.0, start: 75.0), Pin(size: 33.0, middle: 0.2550),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrackingButton()));
                },
                child: const Text(
                  'Track Bus',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 25,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: false,
                ),
              )),
          Pinned.fromPins(
            Pin(size: 45.0, end: 61.0),
            Pin(size: 45.0, middle: 0.2479),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/track.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(113.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 16.0),
            Pin(size: 51.0, middle: 0.3356),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 174.0, start: 45.0), Pin(size: 33.0, middle: 0.3400),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriverEmergencyPortal()));
                },
                child: const Text(
                  'Emergency Alert',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 25,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: false,
                ),
              )),
          Pinned.fromPins(
            Pin(size: 45.0, end: 61.0),
            Pin(size: 45.0, middle: 0.3403),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/emerg.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(113.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 184.0, middle: 0.5),
            Pin(size: 55.0, end: 100.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 84.0, middle: 0.55),
            Pin(size: 33.0, end: 105.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const loginscreendriver()));
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 25,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                ),
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
