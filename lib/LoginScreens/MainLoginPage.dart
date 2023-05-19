import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class MainLoginPage extends StatefulWidget {
  const MainLoginPage({super.key});
  @override
  State<MainLoginPage> createState() => _MainLoginPageState();
}

class _MainLoginPageState extends State<MainLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
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
                fontSize: 38,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 72.0, end: 72.0),
            Pin(size: 56.0, middle: 0.3433),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2ebe9),
                borderRadius: BorderRadius.circular(34.0),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.23, -0.305),
            child: SizedBox(
              width: 198.0,
              height: 34.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/LoginScreenAdmin');
                },
                child: const Text(
                  'Login as Admin',
                  style: TextStyle(
                    fontFamily: 'Franklin Gothic',
                    fontSize: 28,
                    color: Color(0xff2c3333),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 72.0, end: 72.0),
            Pin(size: 56.0, middle: 0.4665),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2ebe9),
                borderRadius: BorderRadius.circular(34.0),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.23, -0.065),
            child: SizedBox(
              width: 214.0,
              height: 34.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/LoginScreenStudent');
                },
                child: const Text(
                  'Login as Student',
                  style: TextStyle(
                    fontFamily: 'Franklin Gothic',
                    fontSize: 28,
                    color: Color(0xff2c3333),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 72.0, end: 72.0),
            Pin(size: 56.0, middle: 0.5897),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff2ebe9),
                borderRadius: BorderRadius.circular(34.0),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.20, 0.175),
            child: SizedBox(
              width: 191.0,
              height: 34.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/LoginScreenDriver');
                },
                child: const Text(
                  'Login as Driver',
                  style: TextStyle(
                    fontFamily: 'Franklin Gothic',
                    fontSize: 28,
                    color: Color(0xff2c3333),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: false,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
