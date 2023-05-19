import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import '../forGlobals.dart' as globals;

class emergencyalertssss extends StatelessWidget {
  emergencyalertssss({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 219.0, start: -13.0),
            Pin(size: 120.0, start: 69.0),
            child: const Text(
              '    EMERGENCY \n         ALERT\n',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 100.0, end: 59.0),
            Pin(size: 100.0, start: 50.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/em3.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(112.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 92.0, start: 25.0),
            Pin(size: 27.0, middle: 0.2809),
            child: const Text(
              'Driver Id:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: Color(0xff000000),
                fontStyle: FontStyle.italic,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 130.0, start: 120.0),
            Pin(size: 33.0, middle: 0.2771),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: TextFormField(
                initialValue: ' ${globals.Driverid}',
                readOnly: true,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 131.0, end: 210.0),
            Pin(size: 27.0, middle: 0.3516),
            child: const Text(
              'Alert Message:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff000000),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
              Pin(start: 2.0, end: 28.0), Pin(size: 177.0, middle: 0.4273),
              child: Container(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) {
                          // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                          // emergencyMessage = value;
                        },
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                            //  labelText: 'Complain Box',
                            hintText: 'Enter Emergency Message Here',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                    ],
                  ))),
          Align(
            alignment: const Alignment(0.0, 0.264),
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
            alignment: Alignment(0.012, 0.257),
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
          Align(
            alignment: Alignment(0.004, 0.487),
            child: Container(
              width: 163.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0.003, 0.473),
            child: SizedBox(
              width: 81.0,
              height: 27.0,
              child: Text(
                ' Go back',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: Color(0xff010000),
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
