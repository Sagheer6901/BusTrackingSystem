import 'dart:async';
import 'package:adobe_xd/adobe_xd.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import '../forGlobals.dart' as globals;

import '../forGlobals.dart';

class Id extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        title: const Text(
          " Point Id Card",
          style: TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 30,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboardforuser())),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          height: height * 0.7,
          width: width * 0.7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CustomPaint(
              size: Size(width, height),
              painter: CardCustomPainter(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/idimage.png',
                          width: width * 0.4,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        globals.studentname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      detailWidget(
                        icon: Icons.supervised_user_circle,
                        text: globals.studentId,
                      ),
                      detailWidget(
                        icon: Icons.location_on,
                        text: studentaddress,
                      ),
                      detailWidget(
                        icon: Icons.phone,
                        text: globals.studentphoneno,
                      ),
                      detailWidget(
                        icon: Icons.bus_alert,
                        text: globals.point,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailWidget({IconData? icon, String? text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[101],
                  ),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
