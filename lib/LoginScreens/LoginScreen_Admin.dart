import 'package:adobe_xd/pinned.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/LoginScreens/MainLoginPage.dart';
import 'package:flutter/services.dart';
import '../SignUpScreens/SignupPage.dart';
import 'LoginPage.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';

class Login_Screenadmin extends StatefulWidget {
  const Login_Screenadmin({super.key});

  @override
  State<Login_Screenadmin> createState() => _Login_ScreenadminState();
}

class _Login_ScreenadminState extends State<Login_Screenadmin> {
  final formKey = GlobalKey<FormState>();
  late var Admin_Id = "12345";
  late var Admin_Password = "admin";

  final TextEditingController _adminidController = TextEditingController();
  final TextEditingController _adminPasswordController =
      TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: formKey,
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
                    image: AssetImage('assets/admin.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(64.0),
                ),
              ),
            ),
            Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text(
                  "Hello Admin",
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 43,
                    color: Colors.black,
                  ),
                ))
          ]),
          Container(
              padding: const EdgeInsets.only(top: 250, left: 20, right: 30),
              child: Column(children: <Widget>[
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_adminidController) =>
                      _adminidController != null &&
                              _adminidController.length > 0 &&
                              _adminidController.length < 4
                          ? 'Enter Mininumum 4 Numbers Not Alphabets'
                          : null,
                  controller: _adminidController,
                  decoration: const InputDecoration(
                      labelText: 'Admin Id',
                      hintText: 'Enter Your Id',
                      labelStyle: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                          color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    cursorColor: Colors.black,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_adminPasswordController) =>
                        _adminPasswordController != null &&
                                _adminPasswordController.length > 0 &&
                                _adminPasswordController.length < 4
                            ? 'Password Must Contain 4 characters'
                            : null,
                    controller: _adminPasswordController,
                    obscureText: _obscureText,
                    // obscuringCharacter: "*",
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
                              _adminPasswordController.value = TextEditingValue(
                                text: _adminPasswordController.text,
                                selection: TextSelection.collapsed(
                                    offset:
                                        _adminPasswordController.text.length),
                              );
                            });
                            focusedBorder:
                            const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            );
                          }),
                    )),
                const SizedBox(height: 5),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                    height: 40,
                    width: 150,
                    child: Material(
                        borderRadius: BorderRadius.circular(34.0),
                        elevation: 5,
                        child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              String admin_id = _adminidController.text;
                              String password = _adminPasswordController.text;
                              if (admin_id.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Admin Id is still empty"),
                                ));
                              } else if (password.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Password is still empty"),
                                ));
                              } else {
                                print(Admin_Id);

                                try {
                                  /*
                                  if (admin_id == Admin_Id) {
                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Wrong Id"),
                                    ));
                                  }
                                  if (password == Admin_Password) {
                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Wrong Password"),
                                    ));
                                  }
                                  */
                                  if (password == Admin_Password &&
                                      admin_id == Admin_Id) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboardforadmin()));
                                    print("Okay");
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Wrong Password or  Wrong Id"),
                                    ));
                                  }
                                } catch (e) {
                                  String error = "";
                                  print(e.toString());
                                  if (e.toString() ==
                                      "RangeError (index): Invalid value: Valid value range is empty: 0") {
                                    setState(() {
                                      error = " Admin Do not Exist";
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
                                _adminidController.clear();
                                _adminPasswordController.clear();
                              }

                              /* final isValid = formKey.currentState!.validate();
                              if (!isValid) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Something You Input Is Wrong"),
                                ));
                              }*/
                            },
                            child: const Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ))))),
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
                            )))))
              ])),
        ]));
  }
}
