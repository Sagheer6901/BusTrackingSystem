import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class uploadfee extends StatelessWidget {
  uploadfee({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 198.0, start: 21.0),
            Pin(size: 40.0, start: 60.0),
            child: const Text(
              'Upload Picture',
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
            Pin(size: 173.0, end: 10.0),
            Pin(size: 139.0, start: 19.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(''),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(101.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 172.0, start: 33.0),
            Pin(size: 33.0, middle: 0.2305),
            child: const Text(
              'Enter Semester:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 25,
                color: Color(0xff000000),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 33.0, start: 33.0),
            Pin(size: 35.0, middle: 0.3839),
            child: const Text(
              'ID:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 26,
                color: Color(0xff000000),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.513),
            child: Container(
              width: 184.0,
              height: 55.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(29.0),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0.012, 0.498),
            child: SizedBox(
              width: 78.0,
              height: 31.0,
              child: Text(
                'Submit',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 23,
                  color: const Color(0xff010000),
                  fontWeight: FontWeight.w700,
                ),
                softWrap: false,
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 163.0, middle: 0.502),
            Pin(size: 50.0, end: 104.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 81.0, middle: 0.5015),
            Pin(size: 27.0, end: 116.0),
            child: const Text(
              ' Go back',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff010000),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
