import 'package:firstapp/SignUpScreens/SignupPage.dart';
import 'package:firstapp/SignUpScreens/SignupPageDriver.dart';
import 'package:flutter/material.dart';

import '../../Dashboards/Dashboardforadmin.dart';
import 'AddRoute.dart';
import 'FetchRoute.dart';

class manageroute extends StatefulWidget {
  const manageroute({Key? key}) : super(key: key);

  @override
  _managerouteState createState() => _managerouteState();
}

class _managerouteState extends State<manageroute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffafdceb),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            color: Colors.black,
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Dashboardforadmin())),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Routes Information',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRoute(),
                    ),
                  )
                },
                child: const Text('Add',
                    style: TextStyle(fontSize: 20.0, color: Colors.black)),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            const ListRoutePage(),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Dashboardforadmin()));
                        },
                        child: const Text('Go Back',
                            style: TextStyle(color: Colors.black)))))
          ],
        ));
  }
}
