import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/SignUpScreens/SignupPage.dart';
import 'package:flutter/material.dart';
import 'usersdatafetch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              'Students Information',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                )
              },
              child: const Text('Add',
                  style: TextStyle(fontSize: 20.00, color: Colors.black)),
              style: ElevatedButton.styleFrom(primary: Colors.white),
            )
          ],
        ),
      ),
      body: Column(children: <Widget>[
        const ListStudentPage(),
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
                    ))))
      ]),
    );
  }
}
