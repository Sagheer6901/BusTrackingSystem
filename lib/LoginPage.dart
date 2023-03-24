// ignore_for_file: unused_import, file_names, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, unnecessary_new, duplicate_ignore
//import 'package:firstapp/LoginScreen.dart';
import 'package:firstapp/Buttonsforuserdashboard/AddFeesScreen.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/MainScreenForDriver.dart';
import 'package:firstapp/LoginScreens/LoginScreenDriver.dart';
import 'package:firstapp/LoginScreens/LoginScreen_Admin.dart';
import 'package:firstapp/LoginScreens/LoginScreen_User.dart';
import 'package:firstapp/MainLoginPage.dart';
import 'package:firstapp/Maps/DriverTrackingPage.dart';
import 'package:firstapp/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'SignUpScreens/SignupPage.dart';
import 'SignUpScreens/SignupPageDriver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        // ignore: unnecessary_new
        '/signup': (BuildContext context) => new SignupPage(),
        // ignore: unnecessary_new
        '/signupdriver': (BuildContext context) => new SignupPageDriver(),
        // ignore: unnecessary_new
        '/LoginScreenAdmin': (BuildContext context) => new Login_Screenadmin(),
        // ignore: unnecessary_new
        '/LoginScreenStudent': (BuildContext context) => new loginscreenuser(),
        '/LoginScreenDriver': (BuildContext context) => new loginscreendriver(),
        '/Main_Login_Page': (BuildContext context) => new MainLoginPage(),
      },
    );
  }
}
