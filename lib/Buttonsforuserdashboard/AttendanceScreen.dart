import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:firstapp/Maps/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../Dashboards/Dashboardforadmin.dart';
import '../forGlobals.dart' as globals;
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';

import '../forGlobals.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

String gstudentid = globals.studentId;

class _AttendanceScreenState extends State<AttendanceScreen> {
  double ScreenHeight = 0;
  double ScreenWidth = 0;
  String CheckIn = "--/-- ";
  String Status = "--/--";

  String location = "";

  @override
  void initState() {
    _getrecord();
  }

  // function to get user location by geocoding
  void _getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(User.long, User.long);

    setState(() {
      location =
          "${placemark[0].street}, ${placemark[0].administrativeArea},${placemark[0].postalCode},${placemark[0].country}";
    });
  }

  void _getrecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Tbl_Student_User")
          .where('Std_Id', isEqualTo: globals.studentId)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Tbl_Student_User")
          .doc(snap.docs[0].id)
          .collection("Tbl_Student_Attendance")
          .doc(
            DateFormat('d MMMM yyyy ').format(DateTime.now()),
          )
          .get();
      setState(() {
        CheckIn = snap2['CheckIn'];
        Status = snap2['Status'];
      });
    } catch (e) {
      setState(() {
        CheckIn = "--/--";
        Status = "--/--";
      });
    }

    //print(CheckIn);
  }

  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.width;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xffafdceb),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  'Welcome Student ',
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaRegular",
                    fontSize: ScreenWidth / 20,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  globals.studentId,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NexaRegular",
                    fontSize: ScreenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Today's Status",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NexaBold ",
                    fontSize: ScreenWidth / 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                height: 150,
                decoration: const BoxDecoration(
                  color: const Color(0xffafdceb),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Check In",
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "NexaRegular ",
                                fontSize: ScreenWidth / 20,
                              ),
                            ),
                            Text(CheckIn,
                                style: TextStyle(
                                  fontFamily: "NexaBold ",
                                  fontSize: ScreenWidth / 20,
                                ))
                          ]),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Attendance",
                              style: TextStyle(
                                fontFamily: "NexaRegular ",
                                fontSize: ScreenWidth / 20,
                                color: Colors.black54,
                              ),
                            ),
                            Text(Status,
                                style: TextStyle(
                                  fontFamily: "NexaBold ",
                                  fontSize: ScreenWidth / 20,
                                ))
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('d MMMM yyyy ').format(DateTime.now()),
                  style: TextStyle(
                    fontFamily: "NexaRegular ",
                    fontSize: ScreenWidth / 20,
                  ),
                ),
              ),
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat('hh:mm:ss a').format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: "NexaRegular ",
                          fontSize: ScreenWidth / 20,
                        ),
                      ),
                    );
                  }),
              // condition if check in is null so print this container
              CheckIn == "--/--"
                  ? Container(
                      margin: const EdgeInsets.only(top: 24, bottom: 150),
                      child: Builder(
                        builder: (context) {
                          final GlobalKey<SlideActionState> key = GlobalKey();
                          return SlideAction(
                            outerColor: Colors.white,
                            innerColor: const Color(0xf00652c5),
                            // condition if checkin is null so print this
                            text: CheckIn == "--/--"
                                ? "Slide To Mark Present"
                                : "",
                            textStyle: TextStyle(
                              color: const Color(0xf00652c5),
                              fontSize: ScreenWidth / 18,
                              fontFamily: 'NexaRegular',
                            ),

                            key: key,
                            onSubmit: () async {
                              if (User.lat != 0) {
                                _getLocation();

                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("Tbl_Student_User")
                                    .where('Std_Id',
                                        isEqualTo: globals.studentId)
                                    .get();

                                // print(snap.docs[0].id);
                                // print(DateFormat('d MMMM yyyy ')
                                //   .format(DateTime.now()));

                                //creating document to get check in time
                                DocumentSnapshot snap2 =
                                    await FirebaseFirestore.instance
                                        .collection("Tbl_Student_User")
                                        .doc(snap.docs[0].id)
                                        .collection("Tbl_Student_Attendance")
                                        .doc(
                                          DateFormat('d MMMM yyyy ')
                                              .format(DateTime.now()),
                                        )
                                        .get();

                                /// to reset
                                key.currentState!.reset();

                                // print(
                                //   DateFormat('hh:mm').format(DateTime.now()));

                                //print(snap2['CheckIn']);

                                // try catch if user didnt get check in
                                try {
                                  String CheckIn = snap2['CheckIn'];
                                  String Status = snap2['Status'];
                                  setState(() {
                                    CheckIn = DateFormat('hh:mm')
                                        .format(DateTime.now());
                                    Status = 'Present';
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("Tbl_Student_User")
                                      .doc(snap.docs[0].id)
                                      .collection("Tbl_Student_Attendance")
                                      .doc(
                                        DateFormat('d MMMM yyyy ')
                                            .format(DateTime.now()),
                                      )
                                      .update({
                                    'CheckIn': CheckIn,
                                    'Status': Status,
                                    'Location': location
                                  });
                                } catch (e) {
                                  setState(() {
                                    CheckIn = DateFormat('hh:mm')
                                        .format(DateTime.now());
                                    Status = 'Present';
                                  });
                                  await FirebaseFirestore.instance
                                      .collection("Tbl_Student_User")
                                      .doc(snap.docs[0].id)
                                      .collection("Tbl_Student_Attendance")
                                      .doc(
                                        DateFormat('d MMMM yyyy ')
                                            .format(DateTime.now()),
                                      )
                                      .set({
                                    'CheckIn': DateFormat('hh:mm')
                                        .format(DateTime.now()),
                                    'Status': 'Present',
                                    'Location': location,
                                  });
                                }
                              } else {
                                Timer(Duration(seconds: 3), () async {
                                  _getLocation();
                                  key.currentState!.reset();
                                  // print(DateFormat('hh:mm')
                                  //  .format(DateTime.now()));

                                  QuerySnapshot snap = await FirebaseFirestore
                                      .instance
                                      .collection("Tbl_Student_User")
                                      .where('Std_Id',
                                          isEqualTo: globals.studentId)
                                      .get();

                                  // print(snap.docs[0].id);
                                  // print(DateFormat('d MMMM yyyy ')
                                  //  .format(DateTime.now()));

                                  //creating document to get check in time
                                  DocumentSnapshot snap2 =
                                      await FirebaseFirestore.instance
                                          //.collection("Tbl_Student_User")
                                          //.doc(snap.docs[0].id)
                                          .collection("Tbl_Student_Attendance")
                                          .doc(
                                            DateFormat('d MMMM yyyy ')
                                                .format(DateTime.now()),
                                          )
                                          .get();
                                  //print(snap2['CheckIn']);

                                  // try catch if user didnt get check in
                                  try {
                                    String CheckIn = snap2['CheckIn'];
                                    String Status = snap2['Status'];
                                    String Location = snap2['location'];
                                    setState(() {
                                      CheckIn = DateFormat('hh:mm')
                                          .format(DateTime.now());
                                      Status = 'Present';
                                    });
                                    await FirebaseFirestore.instance
                                        .collection("Tbl_Student_User")
                                        .doc(snap.docs[0].id)
                                        .collection("Tbl_Student_Attendance")
                                        .doc(
                                          DateFormat('d MMMM yyyy ')
                                              .format(DateTime.now()),
                                        )
                                        .update({
                                      'CheckIn': CheckIn,
                                      'Status': Status,
                                      'Location': location,
                                      'Id': globals.studentId,
                                      'Date': DateFormat('ymd')
                                          .format(DateTime.now())
                                    });
                                  } catch (e) {
                                    setState(() {
                                      CheckIn = DateFormat('hh:mm')
                                          .format(DateTime.now());
                                      Status = 'Present';
                                    });
                                    await FirebaseFirestore.instance
                                        .collection("Tbl_Student_User")
                                        .doc(snap.docs[0].id)
                                        .collection("Tbl_Student_Attendance")
                                        .doc(
                                          DateFormat('d MMMM yyyy ')
                                              .format(DateTime.now()),
                                        )
                                        .set({
                                      'CheckIn': DateFormat('hh:mm a')
                                          .format(DateTime.now()),
                                      'Status': 'Present',
                                      'Location': location,
                                      'Id': globals.studentId,
                                      'Date': DateFormat('yMd')
                                          .format(DateTime.now())
                                    });
                                  }
                                });
                              }
                            },
                          );
                        },
                      ),
                    )
                  // if check in is not null show this
                  : Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 32),
                      child: Text(
                        "You Have Marked Your Attendance Today",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: ScreenWidth / 21,
                          fontFamily: 'NexaRegular',
                        ),
                      ),
                    ), // text widget for showing current location
              location != ""
                  ? Text(
                      "Location" + location,
                    )
                  : const SizedBox(),

              Align(
                alignment: const Alignment(0.004, 0.487),
                child: Container(
                    width: 163.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                    child: Container(
                        alignment: const Alignment(0.100, 0.173),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Dashboardforuser()));
                          },
                          child: const Text(
                            'Go back',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                            softWrap: false,
                          ),
                        ))),
              ),
            ],
          ),
        ));
  }
}
