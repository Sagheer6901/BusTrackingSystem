// ignore_for_file: file_names, prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/LoginScreens/LoginScreen_User.dart';
import 'package:firstapp/LoginScreens/MainLoginPage.dart';
import 'package:firstapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../Buttonsforadmindashboard/ManageUserScreens/manageuser.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

// THIS IS FOR STORING DATA TO FIREBASE
class _SignupPageState extends State<SignupPage> {
  // ignore: non_constant_identifier_names
  CollectionReference Std_users =
      FirebaseFirestore.instance.collection('Tbl_Student_User');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _Stdid = TextEditingController();
  final TextEditingController _stdFullName = TextEditingController();
  final TextEditingController _stdPointId = TextEditingController();
  final TextEditingController _stdContactNo = TextEditingController();
  final TextEditingController _stdAddress = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var user_email;
  late String Std_FullName;
  late String Std_Id;
  late String std_point_Id;
  late String Std_ContactNo;
  late String Std_Address;
  late var Std_Password;
  late String Created_By;
  late String Created_Date;
  late String Modified_By;
  late String Modified_Date;
  late String stdPassEncrypt;

  void showToast() {
    Fluttertoast.showToast(
        msg: "Student Registered Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
        //key: formKey
        backgroundColor: const Color(0xffafdceb),
        resizeToAvoidBottomInset: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(15, 55, 0, 0),
                child: Text("Registration Form",
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: 43,
                      color: Colors.black,
                    )))
          ]),
          Container(
              padding: EdgeInsets.only(top: 02, left: 20, right: 30),
              child: Column(children: <Widget>[
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: _stdFullName,
                  onChanged: (value) {
                    // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                    Std_FullName = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  // for only email
                  keyboardType: TextInputType.emailAddress,
                  // controller for email
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (userEmail) =>
                      userEmail != null && !EmailValidator.validate(userEmail)
                          ? 'Enter Valid Email'
                          : null,

                  onChanged: (value) {
                    user_email = _emailController.text;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: _Stdid,
                  // enter only digits
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Std_Id) =>
                      Std_Id != null && Std_Id.length > 0 && Std_Id.length < 5
                          ? 'Enter Mininumum 5 Numbers Not Alphabets'
                          : null,
                  onChanged: (value) {
                    Std_Id = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Student Id',
                      labelStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: _stdPointId,
                  // enter only digits
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (std_point_Id) => std_point_Id != null &&
                          std_point_Id.length > 0 &&
                          std_point_Id.length < 2
                      ? 'Enter Mininumum 5 Numbers Not Alphabets'
                      : null,
                  onChanged: (value) {
                    std_point_Id = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Point Number',
                      labelStyle: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  cursorColor: Colors.black,
                  controller: _stdContactNo,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Std_Contact_No) => Std_Contact_No != null &&
                          Std_Contact_No.length > 0 &&
                          Std_Contact_No.length < 11
                      ? 'Phone Number Must Be Atleast Of 11 Numbers Not Alphabets'
                      : null,
                  onChanged: (value) {
                    // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                    Std_ContactNo = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: _stdAddress,
                  onChanged: (value) {
                    // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                    Std_Address = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Residential Address',
                      labelStyle: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Std_Password) => Std_Password != null &&
                          Std_Password.length > 0 &&
                          Std_Password.length < 6
                      ? 'Password Must Contain 6 characters'
                      : null,
                  onChanged: (value) {
                    // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                    Std_Password = utf8.encode(_passwordController.text);
                    stdPassEncrypt = sha256.convert(Std_Password).toString();
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: Material(
                        borderRadius: BorderRadius.circular(34.0),
                        shadowColor: Colors.black,
                        elevation: 7,
                        child: GestureDetector(
                            onTap: () async {
                              // ignore: unnecessary_new
                              // for getting DateTime

                              final now = DateTime.now();
                              String formatter = DateFormat('yMd').format(now);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                              // adding users to authentication firebase
                              await _auth
                                  .createUserWithEmailAndPassword(
                                      email: user_email,
                                      password: _passwordController.text)
                                  .then(
                                    (value) => showToast(),
                                  );

                              // AFTER PRESSING SIGN UP BUTTON VALUES STORED IN FIREBASE

                              await Std_users.add({
                                'Created_By': "admin",
                                'Modified_By': "admin",
                                'Modified_Date': formatter,
                                'Created_Date': formatter,
                                'Std_FullName': Std_FullName,
                                'Email': _emailController.text,
                                'Std_Id': Std_Id,
                                'Point_Id': std_point_Id,
                                'Std_Contact_No': Std_ContactNo,
                                'Std_Address': Std_Address,
                                'Password': stdPassEncrypt,
                                'Std_Status': 'True',
                                // ignore: avoid_print
                              }).then(
                                (value) => print('Student Added'),
                              );
                              _stdFullName.clear();
                              _emailController.clear();
                              _Stdid.clear();
                              _stdPointId.clear();
                              _stdContactNo.clear();
                              _stdAddress.clear();
                              _passwordController.clear();
                            },
                            child: Center(
                                child: Text("Sign Up",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Segoe UI',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    )))))),
                SizedBox(
                  height: 15,
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
                                      builder: (context) => const HomePage()));
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
