import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/ButtonsfordriverDashboard/StartingpointEndingpointMap/TrackingButton.dart';
import 'package:firstapp/Buttonsforuserdashboard/AttendanceScreen.dart';
import 'package:firstapp/Buttonsforuserdashboard/idcard.dart';
import 'package:firstapp/Constants/constant.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../forGlobals.dart' as globals;
import '../forGlobals.dart';

class Calendarandhistory extends StatefulWidget {
  const Calendarandhistory({super.key});

  @override
  State<Calendarandhistory> createState() => _CalendarandhistoryState();
}

class _CalendarandhistoryState extends State<Calendarandhistory> {
  double ScreenHeight = 0;
  double ScreenWidth = 0;
  String studentid = gstudentid;

  String _month = DateFormat('MMMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "My Attendance",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaBold",
                    fontSize: ScreenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  _month,
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "NexaBold",
                    fontSize: ScreenWidth / 18,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.all(1),
                child: GestureDetector(
                  onTap: () async {
                    final month = await showMonthYearPicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2099),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: primarycolor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                        primary: primarycolor))),
                            child: child!,
                          );
                        });
                    if (month != null) {
                      setState(() {
                        _month = DateFormat('MMMM').format(month);
                      });
                    }
                  },
                  child: Text(
                    "Pick a Month",
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: "NexaBold",
                      fontSize: ScreenWidth / 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenHeight / 1.4,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Tbl_Student_User")
                        .doc(User.id)
                        .collection("Tbl_Student_Attendance")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        /*
                        print(snapshot.data!.docs);
                        print(snapshot.hasData);
                        print(snapshot.data);
                        */
                        return ListView.builder(
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return DateFormat('MMMM')
                                        .format(snap[index]['date'].toDate()) ==
                                    _month
                                ? Container(
                                    margin: const EdgeInsets.only(
                                        top: 12, left: 6, right: 6),
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          margin: EdgeInsets.only(),
                                          decoration: const BoxDecoration(
                                            color: primarycolor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateFormat('EE\ndd').format(
                                                  snap[index]['date'].toDate()),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "NexaBold",
                                                  fontSize: ScreenWidth / 18),
                                            ),
                                          ),
                                        )),
                                        Expanded(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Check In",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily: "NexaRegular ",
                                                    fontSize: ScreenWidth / 20,
                                                  ),
                                                ),
                                                Text(snap[index]['CheckIn'],
                                                    style: TextStyle(
                                                      fontFamily: "NexaBold ",
                                                      fontSize:
                                                          ScreenWidth / 20,
                                                    ))
                                              ]),
                                        ),
                                      ],
                                    ))
                                : const SizedBox();
                          },
                        );
                      } else {
                        return Text(User.id);
                      }
                    }),
              ),
            ])));
  }
}
