import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:firstapp/Dashboards/MainScreenForDriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'MainLoginPage.dart';
import '../forGlobals.dart' as globals;

class loginscreendriver extends StatefulWidget {
  const loginscreendriver({super.key});

  @override
  State<loginscreendriver> createState() => _loginscreendriverState();
}

final TextEditingController _DriveridController = TextEditingController();
final TextEditingController _DriverPasswordController = TextEditingController();
final formKey = GlobalKey<FormState>();

var DriverPassword;
var DriverPassEncrypt;

class _loginscreendriverState extends State<loginscreendriver> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    key:
    formKey;
    var scaffold = Scaffold(
        backgroundColor: const Color(0xffafdceb),
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Stack(children: <Widget>[
            Pinned.fromPins(
              Pin(size: 100.0, end: 19.0),
              Pin(size: 100.0, start: 80.0),
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/driver.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(64.0),
                ),
              ),
            ),
            Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text("Hello Driver",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 43,
                      color: Colors.black,
                    )))
          ]),
          Container(
              padding: const EdgeInsets.only(top: 250, left: 20, right: 30),
              child: Column(children: <Widget>[
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_DriveridController) =>
                      _DriveridController != null &&
                              _DriveridController.length > 0 &&
                              _DriveridController.length < 5
                          ? 'Enter Mininumum 5 Numbers Not Alphabets'
                          : null,
                  controller: _DriveridController,
                  decoration: const InputDecoration(
                      labelText: 'Diver Id',
                      hintText: 'Enter your ID',
                      labelStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_DriverPasswordController) =>
                        _DriverPasswordController != null &&
                                _DriverPasswordController.length > 0 &&
                                _DriverPasswordController.length < 6
                            ? 'Password Must Contain 6 characters'
                            : null,
                    obscureText: _obscureText,
                    controller: _DriverPasswordController,
                    onChanged: (value) {
                      DriverPassword =
                          utf8.encode(_DriverPasswordController.text);
                      DriverPassEncrypt =
                          sha256.convert(DriverPassword).toString();
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                                _DriverPasswordController.value =
                                    TextEditingValue(
                                  text: _DriverPasswordController.text,
                                  selection: TextSelection.collapsed(
                                      offset: _DriverPasswordController
                                          .text.length),
                                );
                              });
                            }))),
/*
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      )),
                ),
                */
                const SizedBox(
                  height: 85,
                ),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: Material(
                        borderRadius: BorderRadius.circular(34.0),
                        elevation: 7,
                        child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              String id = _DriveridController.text;
                              var password = DriverPassEncrypt;
                              if (id.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Driver Id is still empty"),
                                ));
                              } else if (password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Password is still empty"),
                                ));
                              } else {
                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("Tbl_Driver_User")
                                    .where('Driver_Id', isEqualTo: id)
                                    .get();
                                // print("Valid Details");

                                try {
                                  /*
                                  if (id == snap.docs[0]['Std_Id']) {
                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Wrong Id"),
                                    ));
                                  }
                                  if (password == snap.docs[0]['Password']) {
                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Wrong Password"),
                                    ));
                                  }
                                  */
                                  if (id == snap.docs[0]['Driver_Id'] ||
                                      password == snap.docs[0]['Password']) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreenForDriver()));
                                    globals.Driverid = id;
                                    globals.driverName =
                                        snap.docs[0]['Driver_FullName'];
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Wrong Password or Wrong Id"),
                                    ));
                                  }
                                  print(password);
                                } catch (e) {
                                  String error = "";
                                  print(e.toString());
                                  if (e.toString() ==
                                      "RangeError (index): Invalid value: Valid value range is empty: 0") {
                                    setState(() {
                                      error = " Driver Do not Exist";
                                    });
                                  } else {
                                    setState(() {
                                      error = "Error Occured";
                                    });
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(error),
                                  ));
                                }
                              }
                              /*
                              final isValid = formKey.currentState!.validate();
                              if (!isValid) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Something You Input Is Wrong"),
                                ));
                              }
                              */
                              _DriveridController.clear();
                              _DriverPasswordController.clear();
                            },
                            // ignore: prefer_const_constructors
                            child: Center(
                                child: const Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                color: Color(0xff010000),
                                fontWeight: FontWeight.w700,
                              ),
                            ))))),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: Material(
                        borderRadius: BorderRadius.circular(34.0),
                        elevation: 7,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainLoginPage()));
                            },
                            child: const Center(
                                child: Text(
                              'Go Back',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                color: Color(0xff010000),
                                fontWeight: FontWeight.w700,
                              ),
                            ))))),
              ])),
        ]));
    return scaffold;
  }
}
