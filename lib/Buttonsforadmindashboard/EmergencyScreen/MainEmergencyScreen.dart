import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/DriverAlerts/driveralertscreen.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/StudentAlerts/fetch_emergency_students.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/StudentAlerts/studentalertscreen.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class MainEmergencyPage extends StatefulWidget {
  const MainEmergencyPage({super.key});
  @override
  State<MainEmergencyPage> createState() => _MainEmergencyPageState();
}

class _MainEmergencyPageState extends State<MainEmergencyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffafdceb),
        body: Stack(
          children: <Widget>[
            Pinned.fromPins(
              Pin(size: 219.0, start: 0.0),
              Pin(size: 120.0, start: 87.0),
              child: const Text(
                '    EMERGENCY \n       ALERTS\n',
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
                Pin(size: 280.0, start: 38.0), Pin(size: 120.0, middle: 0.3543),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AlertScreenStudent()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(38.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                )),
            const Align(
              alignment: Alignment(-0.476, -0.295),
              child: SizedBox(
                width: 131.0,
                height: 66.0,
                child: Text(
                  'Alerts from \nStudents',
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
            Pinned.fromPins(
              Pin(size: 110.0, end: 49.0),
              Pin(size: 110.0, start: 70.0),
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/em1.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(113.0),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.448, -0.274),
              child: Container(
                width: 82.0,
                height: 82.0,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/em2.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(108.0),
                ),
              ),
            ),
            Pinned.fromPins(
                Pin(size: 280.0, start: 38.0), Pin(size: 120.0, middle: 0.5761),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AlertScreenDriver()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(38.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                )),
            const Align(
              alignment: Alignment(-0.476, 0.114),
              child: SizedBox(
                width: 141.0,
                height: 66.0,
                child: Text(
                  'Alerts from \nDrivers',
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
            Align(
              alignment: const Alignment(0.448, 0.143),
              child: Container(
                width: 82.0,
                height: 82.0,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/em2.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(108.0),
                ),
              ),
            ),
            Pinned.fromPins(
              Pin(size: 184.0, middle: 0.5),
              Pin(size: 55.0, end: 55.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(29.0),
                  border:
                      Border.all(width: 1.0, color: const Color(0xff707070)),
                ),
              ),
            ),
            Pinned.fromPins(
              Pin(size: 84.0, middle: 0.52),
              Pin(size: 33.0, end: 65.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboardforadmin()));
                },
                child: const Text(
                  'Go Back',
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
        ));
  }
}
