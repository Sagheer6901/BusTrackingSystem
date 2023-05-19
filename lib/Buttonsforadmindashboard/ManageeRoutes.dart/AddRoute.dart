// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MainRoute.dart';
// ignore: depend_on_referenced_packages

final FirebaseAuth _auth = FirebaseAuth.instance;

class AddRoute extends StatefulWidget {
  const AddRoute({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddRouteState createState() => _AddRouteState();
}

// THIS IS FOR STORING DATA TO FIREBASE
class _AddRouteState extends State<AddRoute> {
  // ignore: non_constant_identifier_names
  CollectionReference Routes_admin =
      FirebaseFirestore.instance.collection('Tbl_Routes_Admin');

  final formKey = GlobalKey<FormState>();

  var Point_Id;
  late String Routes;

  void showToast() {
    Fluttertoast.showToast(
        msg: "Route Added  Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
        //key: _formKey
        backgroundColor: const Color(0xffafdceb),
        resizeToAvoidBottomInset: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15, 75, 0, 0),
                    child: Text(" Add Route ",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)))
              ]),
              Container(
                  padding: EdgeInsets.only(top: 35, left: 20, right: 30),
                  child: Column(children: <Widget>[
                    TextFormField(
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Point_Id = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Point Number',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 169, 240, 172)),
                          )),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onChanged: (value) {
                        Routes = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'Routes',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        height: 40,
                        width: 100,
                        child: Material(
                            borderRadius: BorderRadius.circular(32.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.white,
                            elevation: 7,
                            child: GestureDetector(
                                onTap: () async {
                                  // AFTER PRESSING SIGN UP BUTTON VALUES STORED IN FIREBASE

                                  await Routes_admin.add({
                                    'Point_Id': Point_Id,
                                    'Route': Routes,
                                    // ignore: avoid_print
                                  }).then(
                                    (value) => print('Route Added'),
                                  );
                                  showToast();
                                },
                                child: Center(
                                    child: Text(
                                  "Add Route",
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      color: const Color(0xff000000),
                                      fontFamily: 'Segoe UI',
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600),
                                ))))),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        height: 40,
                        width: 100,
                        child: Material(
                            borderRadius: BorderRadius.circular(32.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.white,
                            elevation: 7,
                            child: GestureDetector(
                                onTap: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const manageroute()));
                                },
                                child: Center(
                                    child: Text(
                                  "Go Back",
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      color: const Color(0xff000000),
                                      fontFamily: 'Segoe UI',
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600),
                                ))))),
                  ])),
            ]));
  }
/*
  Future signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _PasswordController.text.trim(),
    );
  }
  */
}
