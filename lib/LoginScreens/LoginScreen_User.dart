import 'package:adobe_xd/adobe_xd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart ' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Buttonsforuserdashboard/AttendanceScreen.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:firstapp/forGlobals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'MainLoginPage.dart';
import '../SignUpScreens/SignupPage.dart';
import 'LoginPage.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../forGlobals.dart' as globals;
import '../forGlobals.dart';

class loginscreenuser extends StatefulWidget {
  const loginscreenuser({super.key});

  @override
  State<loginscreenuser> createState() => _loginscreenuserState();
}

final TextEditingController _idController = TextEditingController();
final TextEditingController _PasswordController = TextEditingController();

final userId = auth.FirebaseAuth.instance.currentUser?.uid;

var UserPassword;
var UserPassEncrypt;
late String address;
late String phoneno;
late String point;
late String name;

bool _obscureText = true;

class _loginscreenuserState extends State<loginscreenuser> {
  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage('assets/user.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(64.0),
                ),
              ),
            ),
            Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text("Hello User",
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
                  validator: (_idController) => _idController != null &&
                          _idController.length > 0 &&
                          _idController.length < 5
                      ? 'Enter Mininumum 5 Numbers Not Alphabets'
                      : null,
                  controller: _idController,
                  decoration: const InputDecoration(
                      labelText: 'User Id',
                      hintText: 'Enter Your Id',
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
                const SizedBox(height: 20),
                TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (PasswordController) =>
                        PasswordController != null &&
                                PasswordController.length > 0 &&
                                PasswordController.length < 6
                            ? 'Password Must Contain 6 characters'
                            : null,
                    obscureText: _obscureText,
                    //obscuringCharacter: "*",
                    controller: _PasswordController,
                    onChanged: (value) {
                      // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                      UserPassword = utf8.encode(_PasswordController.text);
                      UserPassEncrypt = sha256.convert(UserPassword).toString();
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
                                _PasswordController.value = TextEditingValue(
                                  text: _PasswordController.text,
                                  selection: TextSelection.collapsed(
                                      offset: _PasswordController.text.length),
                                );
                              });
                            }))),
                const SizedBox(
                  height: 85,
                ),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: Material(
                        borderRadius: BorderRadius.circular(62.0),
                        elevation: 7,
                        child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              String id = _idController.text;
                              String password = UserPassEncrypt;
                              if (id.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Student Id is still empty"),
                                ));
                              } else if (password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Password is still empty"),
                                ));
                              } else {
                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("Tbl_Student_User")
                                    .where('Std_Id', isEqualTo: id)
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
                                  if (id == snap.docs[0]['Std_Id'] &&
                                      password == snap.docs[0]['Password']) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboardforuser()));
                                    globals.studentId = id;
                                    globals.studentaddress =
                                        snap.docs[0]['Std_Address'];
                                    globals.studentname =
                                        snap.docs[0]['Std_FullName'];
                                    globals.studentphoneno =
                                        snap.docs[0]['Std_Contact_No'];
                                    globals.point = snap.docs[0]['Point_Id'];

                                    _idController.clear();
                                    _PasswordController.clear();

                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Wrong Password or Wrong Id"),
                                    ));
                                  }
                                } catch (e) {
                                  String error = "";
                                  print(e.toString());
                                  if (e.toString() ==
                                      "RangeError (index): Invalid value: Valid value range is empty: 0") {
                                    setState(() {
                                      error = " Student Do not Exist";
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
                            },
                            // ignore: prefer_const_constructors
                            child: Center(
                                child: const Text("Login",
                                    style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    )))))),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ))))),
              ])),
        ]));

    return scaffold;
  }
}
