import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IdCard extends StatefulWidget {
  const IdCard({Key? key}) : super(key: key);

  @override
  IdCardState createState() => IdCardState();
}

class IdCardState extends State<IdCard> {
  // to get all the documents in collection
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Tbl_Student_User').snapshots();

  File? imgFile;

  @override
  void initState() {
    Permission.storage.request();
    super.initState();
  }

  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    Colors.accents;
    // to fetch realtime database information
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          // to fetch data quickly
          //Values/items stored in a map can be referenced multiple times within your code
          //and only be retrieved or reached using its associated Key. Maps in Dart are
          //similar to dictionaries in Python and accept data of any type for the key and value pairs.

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map dataa = document.data() as Map<String, dynamic>;
            storedocs.add(dataa);
            dataa['id'] = document.id;
          }).toList();
          //print(storedocs);
          // ignore: unnecessary_new
          return new Scaffold(
              backgroundColor: const Color(0xffdcd3d3),
              resizeToAvoidBottomInset: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(15, 75, 0, 0),
                        child: const Text("Id Card",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)))
                  ]),
                  Container(
                      padding:
                          const EdgeInsets.only(top: 35, left: 20, right: 30),
                      child: Column(
                        children: [
                          TextFormField(
                            // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                            initialValue: '${storedocs[0]['Std_FullName']}',

                            decoration: const InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 169, 240, 172)),
                                )),
                          ),
                          TextFormField(
                            // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                            initialValue: '${storedocs[0]['Std_Id']}',

                            decoration: const InputDecoration(
                                labelText: 'Student Id',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 169, 240, 172)),
                                )),
                          ),
                          TextFormField(
                            // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                            initialValue: '${storedocs[0]['Point_Id']}',

                            decoration: const InputDecoration(
                                labelText: 'Point Id',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 169, 240, 172)),
                                )),
                          ),
                          TextFormField(
                            // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                            initialValue: '${storedocs[0]['Std_Contact_No']}',

                            decoration: const InputDecoration(
                                labelText: 'Contact No',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 169, 240, 172)),
                                )),
                          ),
                          TextFormField(
                            // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                            initialValue: '${storedocs[0]['Std_Address']}',

                            decoration: const InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 169, 240, 172)),
                                )),
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 20, right: 30),
                              alignment: Alignment.bottomCenter,
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Dashboardforuser()));
                                      },
                                      child: const Text('<-- Go Back')))),
                          !_canShowButton
                              ? const SizedBox.shrink()
                              : Container(
                                  padding: const EdgeInsets.only(
                                      top: 60, left: 20, right: 30),
                                  alignment: Alignment.bottomCenter,
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black),
                                          onPressed: () async {},
                                          child:
                                              const Text('Capture Id Card')))),
                        ],
                      )),
                ],
              ));
        });
  }
}
