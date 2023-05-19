import 'package:firstapp/SignUpScreens/SignupPage.dart';
import 'package:firstapp/SignUpScreens/SignupPageDriver.dart';
import 'package:flutter/material.dart';
import '../../Dashboards/Dashboardforadmin.dart';
import 'driverfetchdata.dart';

class managedriver extends StatefulWidget {
  const managedriver({Key? key}) : super(key: key);

  @override
  _managedriverState createState() => _managedriverState();
}

class _managedriverState extends State<managedriver> {
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
            children: [
              const Text(
                'Driver Information',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPageDriver(),
                    ),
                  )
                },
                child: const Text('Add',
                    style: TextStyle(fontSize: 20.0, color: Colors.black)),
                style: ElevatedButton.styleFrom(primary: Colors.white),
              )
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            const ListDriverPage(),
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
