import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Buttonsforadmindashboard/AttendanceScreen/MainScreen.dart';
import 'package:firstapp/Buttonsforadmindashboard/ComplainScreen/StudentComplain.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/MainEmergencyScreen.dart';
import 'package:firstapp/Buttonsforadmindashboard/FeesInfoScreen/MainFeesScreen.dart';
import 'package:firstapp/Buttonsforadmindashboard/ManageeRoutes.dart/MainRoute.dart';
import 'package:firstapp/LoginScreens/LoginScreen_Admin.dart';
import 'package:firstapp/LoginScreens/LoginScreen_Admin.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import '../Buttonsforadmindashboard/ManageDriverScreens/managedriver.dart';
import '../Buttonsforadmindashboard/ManageUserScreens/manageuser.dart';
import '../forGlobals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboardforadmin extends StatefulWidget {
  const Dashboardforadmin({super.key});
  @override
  State<Dashboardforadmin> createState() => _DashboardforadminState();
}

const int SESSION_TIMEOUT = 5; // 5 minutes in seconds
//const int SESSION_TIMEOUT = 5 * 60; // 5 minutes in seconds

class _DashboardforadminState extends State<Dashboardforadmin> {
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

  /*
  void initState() {
    super.initState();
    getid();
  }

  // method to get data of respective id

  void getid() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('Tbl_Student_User')
        .where('Std_Id', isEqualTo: User.id)
        .get();
    setState(() {
      User.id = snap.docs[0].id;
    });
    */

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
              '    ADMIN\nDASHBOARD',
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
                  image: AssetImage('assets/admindashboard.png'),
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
              Pin(size: 154.0, start: 55.0), Pin(size: 33.0, middle: 0.2550),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text(
                  'Manage User',
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
                  image: AssetImage('assets/manageuser.png'),
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
              Pin(size: 174.0, start: 55.0), Pin(size: 33.0, middle: 0.3396),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const managedriver()));
                },
                child: const Text(
                  'Manage Driver',
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
                  image: AssetImage('assets/managedriver.png'),
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
                          builder: (context) => const FeesScreenStudent()));
                },
                child: const Text(
                  'Fee Information',
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
                  image: AssetImage('assets/fees.png'),
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
              Pin(size: 171.0, start: 55.0), Pin(size: 33.0, middle: 0.5208),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AttendanceScreenStudent()));
                },
                child: const Text(
                  'In/Out History',
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
                  image: AssetImage('assets/inout.png'),
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const manageroute()));
                },
                child: const Text(
                  'Manage Routes',
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
            Pin(size: 45.0, middle: 0.6160),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/loc.png'),
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
              Pin(size: 182.0, start: 80.0), Pin(size: 33.0, middle: 0.7107),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboardforadmin()));
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
            Pin(size: 45.0, middle: 0.7028),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/track.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(112.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 22.0),
            Pin(size: 51.0, middle: 0.795),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 195.0, start: 55.0), Pin(size: 33.0, middle: 0.7879),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainEmergencyPage()));
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
            Pin(size: 45.0, middle: 0.7926),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/emerg.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 212.0, start: 22.0),
            Pin(size: 51.0, end: 84.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Pinned.fromPins(
              Pin(size: 112.0, middle: 0.3333), Pin(size: 33.0, end: 90.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ComplainScreenStudent()));
                },
                child: const Text(
                  'Complain',
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
            Pin(size: 45.0, middle: 0.7926),
            Pin(size: 45.0, end: 86.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/comp.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(49.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 184.0, middle: 0.5),
            Pin(size: 55.0, end: 15.0),
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
            Pin(size: 33.0, end: 26.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Login_Screenadmin()));
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
