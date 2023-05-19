import 'package:firstapp/Buttonsforadmindashboard/AttendanceScreen/fetchattendancee.dart';
import 'package:firstapp/Buttonsforadmindashboard/ComplainScreen/fetchcomplain.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/DriverAlerts/fetch_emergency_driver.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/StudentAlerts/fetch_emergency_students.dart';
import 'package:firstapp/SignUpScreens/SignupPage.dart';
import 'package:flutter/material.dart';

import '../../Dashboards/Dashboardforadmin.dart';
import 'fetchattendance.dart';

class AttendanceScreenStudent extends StatefulWidget {
  const AttendanceScreenStudent({Key? key}) : super(key: key);

  @override
  _AttendanceScreenStudentState createState() =>
      _AttendanceScreenStudentState();
}

class _AttendanceScreenStudentState extends State<AttendanceScreenStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Dashboardforadmin())),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Attendance Information',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: <Widget>[
        const fetchattendncePage(),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboardforadmin()));
                    },
                    child: const Text(
                      'Go Back',
                      style: TextStyle(color: Colors.black),
                    )))),
      ]),
    );
  }
}
