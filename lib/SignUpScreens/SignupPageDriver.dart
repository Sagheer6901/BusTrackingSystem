// ignore: file_names
// ignore_for_file: sized_box_for_whitespace
import 'package:firstapp/Buttonsforadmindashboard/ManageDriverScreens/managedriver.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/forGlobals.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

// ignore: unused_element
final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPageDriver extends StatefulWidget {
  const SignupPageDriver({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPageDriver> {
  CollectionReference Driver_users =
      FirebaseFirestore.instance.collection('Tbl_Driver_User');

  final TextEditingController _Driver_Idcontroller = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _Driver_FullNamecontroller =
      TextEditingController();
  final TextEditingController _point_idcontroller = TextEditingController();
  final TextEditingController _Driver_ContactNoController =
      TextEditingController();
  final TextEditingController _Driver_NIC_NOController =
      TextEditingController();
  final TextEditingController _Driver_Veh_Reg_NoController =
      TextEditingController();
  final TextEditingController _Driver_Vehicle_TypeController =
      TextEditingController();

  late String Driver_FullName;
  late String Driver_Id;
  late String point_id;
  late String Driver_ContactNo;
  late String Driver_NIC_NO;
  late String Driver_Veh_Reg_No;
  late String Driver_Vehicle_Type;
  late var Driver_Password;
  late String Created_By;
  late String Created_Date;
  late String Modified_By;
  late String Modified_Date;
  late var Driv_PasswordEncrypt;

  void showToast() {
    Fluttertoast.showToast(
        msg: "Driver Registered Successfully",
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
        backgroundColor: const Color(0xffafdceb),
        resizeToAvoidBottomInset: false,
        drawerDragStartBehavior: DragStartBehavior.start,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // ignore: avoid_unnecessary_containers
              Container(
                child: Stack(children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(15, 45, 0, 0),
                      // ignore: prefer_const_constructors
                      child: Text("Registration Form",
                          style: const TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 43,
                              color: Colors.black)))
                ]),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 0.2, left: 20, right: 30),
                  child: Column(children: <Widget>[
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_FullNamecontroller,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_FullName = value;
                      },
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          // ignore: prefer_const_constructors
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_Idcontroller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (Driver_Id) => Driver_Id != null &&
                              Driver_Id.length > 0 &&
                              Driver_Id.length < 5
                          ? 'Enter Mininumum 5 Numbers Not Alphabets'
                          : null,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_Id = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Driver Id',
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
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _point_idcontroller,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (point_id) => point_id != null &&
                              point_id.length > 0 &&
                              point_id.length < 2
                          ? 'Enter Mininumum 2 Numbers Not Alphabets'
                          : null,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        point_id = value;
                      },
                      decoration: const InputDecoration(
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
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_ContactNoController,
                      // controller: _Driver_ContactNo,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (Driver_ContactNo) => Driver_ContactNo !=
                                  null &&
                              Driver_ContactNo.length > 0 &&
                              Driver_ContactNo.length < 14
                          ? 'Phone Number Must Be Atleast Of 14 Numbers Not Alphabets'
                          : null,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_ContactNo = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_NIC_NOController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (Driver_NIC_NO) => Driver_NIC_NO != null &&
                              Driver_NIC_NO.length > 0 &&
                              Driver_NIC_NO.length < 13
                          ? 'Phone Number Must Be Atleast Of 11 Numbers Not Alphabets'
                          : null,
                      //controller: _DriveremailController,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_NIC_NO = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'NIC-Number',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_Veh_Reg_NoController,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_Veh_Reg_No = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Vehicle Registration No',
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
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: _Driver_Vehicle_TypeController,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_Vehicle_Type = value;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Vehicle Type',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _PasswordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (Std_Password) => Driver_Password != null &&
                              Driver_Password.length > 0 &&
                              Driver_Password.length < 6
                          ? 'Password Must Contain 6 characters'
                          : null,
                      onChanged: (value) {
                        // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                        Driver_Password = utf8.encode(_PasswordController.text);
                        Driv_PasswordEncrypt =
                            sha256.convert(Driver_Password).toString();
                      },
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 40,
                        width: 150,
                        child: Material(
                            borderRadius: BorderRadius.circular(34.0),
                            shadowColor: Colors.black,
                            color: Colors.white,
                            elevation: 7,
                            child: GestureDetector(
                                onTap: () async {
                                  // ignore: unnecessary_new
                                  // for getting date
                                  final now = DateTime.now();
                                  String formatter =
                                      DateFormat('yMd').format(now);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const managedriver()));

                                  // adding users to authentication firebase
                                  /*
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _Driver_ContactNo.text,
                                      password: _PasswordController.text);
                              
*/
                                  // AFTER PRESSING SIGN UP BUTTON VALUES STORED IN FIREBASE
                                  await Driver_users.add({
                                    'Created_By': "admin",
                                    'Modified_By': "admin",
                                    'Modified_Date': formatter,
                                    'Created_Date': formatter,
                                    'Driver_FullName': Driver_FullName,
                                    'Driver_Id': Driver_Id,
                                    'Point_Id': point_id,
                                    'Driver_Contact_No': Driver_ContactNo,
                                    'Driver_NIC_Number': Driver_NIC_NO,
                                    'Driver_Veh_Reg_No': Driver_Veh_Reg_No,
                                    'Driver_Vehicle_Type': Driver_Vehicle_Type,
                                    'Driver_Password': Driv_PasswordEncrypt,
                                    'Status': 'Active',
                                  }).then((value) => showToast());
                                  _Driver_FullNamecontroller.clear();
                                  _Driver_Idcontroller.clear();
                                  _point_idcontroller.clear();
                                  _Driver_ContactNoController.clear();
                                  _Driver_NIC_NOController.clear();
                                  _Driver_Veh_Reg_NoController.clear;
                                  _Driver_Vehicle_TypeController.clear();
                                  _PasswordController.clear();
                                },
                                child: const Center(
                                    child: Text(
                                  "Register",
                                  style: TextStyle(
                                      backgroundColor: Colors.white,
                                      color: const Color(0xff000000),
                                      fontFamily: 'Segoe UI',
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600),
                                ))))),
                    const SizedBox(
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
                                          builder: (context) =>
                                              const managedriver()));
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
                  ]))
            ]));
  }
}
