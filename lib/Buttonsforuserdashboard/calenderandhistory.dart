import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../forGlobals.dart' as globals;
import '../forGlobals.dart';

class Calendarandhistory extends StatefulWidget {
  const Calendarandhistory({super.key});

  @override
  State<Calendarandhistory> createState() => _CalendarandhistoryState();
}

double ScreenHeight = 0;
double ScreenWidth = 0;
String gstudentid = globals.studentId;

class _CalendarandhistoryState extends State<Calendarandhistory> {
  String checkin = "-/--";
  String checkout = "--/--";

  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.width;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              DateFormat('MMMM').format(DateTime.now()),
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
              "Pick a Month",
              style: TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
                fontSize: ScreenWidth / 18,
              ),
            ),
          ),
          Container(
            height: ScreenHeight - ScreenHeight / 5,
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
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Text(snap[index]['CheckIn']),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          )
        ],
      ),
    ));
  }
}
