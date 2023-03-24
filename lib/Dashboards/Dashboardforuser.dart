import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Buttonsforuserdashboard/AddFeesScreen.dart';
import 'package:firstapp/Buttonsforuserdashboard/AttendanceScreen.dart';
import 'package:firstapp/Buttonsforuserdashboard/ComplaintPortal.dart';
import 'package:firstapp/Buttonsforuserdashboard/EmergencyAlert.dart';
import 'package:firstapp/Buttonsforuserdashboard/GenerateIdCard.dart';
import 'package:firstapp/Buttonsforuserdashboard/getting_user_location.dart';
import 'package:firstapp/Buttonsforuserdashboard/idcard.dart';
import 'package:firstapp/LoginScreens/LoginScreen_User.dart';
import 'package:firstapp/user_Tracker.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/MainLoginPage.dart';
import 'package:adobe_xd/pinned.dart';
import '../forGlobals.dart';

class Dashboardforuser extends StatefulWidget {
  const Dashboardforuser({super.key});

  @override
  State<Dashboardforuser> createState() => _DashboardforuserState();
}

const int SESSION_TIMEOUT = 5; // 5 minutes in seconds

class _DashboardforuserState extends State<Dashboardforuser> {
  String id = '';

  Timer? _sessionTimer;

  void _startSessionTimer() {
    // Cancel any existing timer before starting a new one
    _cancelSessionTimer();

    // Start a new session timer
    _sessionTimer = Timer(const Duration(seconds: SESSION_TIMEOUT), () {
      // Session has timed out, navigate to login page
      Navigator.pushReplacementNamed(context, '/LoginScreenStudent');
    });
  }

  void _cancelSessionTimer() {
    if (_sessionTimer != null) {
      _sessionTimer!.cancel();
      _sessionTimer = null;
    }
  }

  @override
  void dispose() {
    _cancelSessionTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startLocationService();
    _startSessionTimer();
  }

  // for geeting user location
  void _startLocationService() async {
    LocationService().initialize();

    LocationService().getLongitude().then((value) {
      setState(() {
        User.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          User.long = value!;
        });
      });
    });
    // at the start of homescreen we will get user data
    /*
    @override
    void initState() {
      super.initState();

      getid();
    }
  }

  // method to get data of respective id
  void getid() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Tbl_Student_User")
        .where('Std_Id', isEqualTo: User.userId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 187.0, start: 45.0),
            Pin(size: 80.0, start: 65.0),
            child: const Text(
              '   STUDENT\n DASHBOARD',
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
                  image: AssetImage('assets/studentdashboard.png'),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => User_Tracking()));
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
              Pin(size: 174.0, start: 75.0), Pin(size: 33.0, middle: 0.3396),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendanceScreen()));
                },
                child: const Text(
                  'Attendance',
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
                  image: AssetImage('assets/inout.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(113.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 18.0),
            Pin(size: 51.0, middle: 0.4333),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 188.0, start: 55.0), Pin(size: 33.0, middle: 0.4349),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ComplaintPortal()));
                },
                child: const Text(
                  'Complain Portal',
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
            Pin(size: 45.0, middle: 0.4390),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/comp.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(110.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 20.0),
            Pin(size: 51.0, middle: 0.5227),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 171.0, start: 95.0), Pin(size: 33.0, middle: 0.5208),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Id()));
                },
                child: const Text(
                  'Id Card',
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
            Pin(size: 45.0, middle: 0.5250),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/idcard.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(31.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 19.0),
            Pin(size: 51.0, middle: 0.6149),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 182.0, start: 55.0), Pin(size: 33.0, middle: 0.6107),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const AddItem()));
                },
                child: const Text(
                  'Upload Voucher',
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
            Pin(size: 45.0, middle: 0.6150),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/fees.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(38.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 22.0),
            Pin(size: 51.0, middle: 0.707),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 22.0),
            Pin(size: 51.0, middle: 0.707),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 182.0, start: 50.0), Pin(size: 33.0, middle: 0.7065),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyPortal()));
                },
                child: const Text(
                  'Emergency Alerts',
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
            Pin(size: 45.0, middle: 0.7028),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/emerg.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(112.0),
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
                        builder: (context) => const loginscreenuser()));
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
