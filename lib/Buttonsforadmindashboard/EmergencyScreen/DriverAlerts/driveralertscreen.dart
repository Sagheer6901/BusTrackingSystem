import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/DriverAlerts/fetch_emergency_driver.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/MainEmergencyScreen.dart';
import 'package:firstapp/Buttonsforadmindashboard/EmergencyScreen/StudentAlerts/fetch_emergency_students.dart';
import 'package:firstapp/SignUpScreens/SignupPage.dart';
import 'package:flutter/material.dart';

import '../../../Dashboards/Dashboardforadmin.dart';

class AlertScreenDriver extends StatefulWidget {
  const AlertScreenDriver({Key? key}) : super(key: key);

  @override
  _AlertScreenDriverState createState() => _AlertScreenDriverState();
}

class _AlertScreenDriverState extends State<AlertScreenDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Driver Alert Information',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ],
        ),
      ),
      body: Column(children: <Widget>[
        const fetchemergencydriver(),
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
                              builder: (context) => const MainEmergencyPage()));
                    },
                    child: const Text('Go Back',
                        style: TextStyle(color: Colors.black)))))
      ]),
    );
  }
}
