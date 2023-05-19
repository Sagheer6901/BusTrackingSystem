import 'package:firstapp/Buttonsforuserdashboard/AttendanceScreen.dart';
import 'package:firstapp/Buttonsforuserdashboard/calenderandhistory.dart';
import 'package:firstapp/Buttonsforuserdashboard/idcard.dart';
import 'package:firstapp/Dashboards/Dashboardforuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Constants/constant.dart';

class MainAttendanceandhistoryscreen extends StatefulWidget {
  const MainAttendanceandhistoryscreen({super.key});

  @override
  State<MainAttendanceandhistoryscreen> createState() =>
      _MainAttendanceandhistoryscreenState();
}

int currentIndex = 0;
double ScreenHeight = 0;
double ScreenWidth = 0;

Color primary = const Color(0xffeef444c);

List<IconData> navigationIcons = [
  FontAwesomeIcons.calendarAlt,
  FontAwesomeIcons.check,
  FontAwesomeIcons.userAlt,
  // FontAwesomeIcons.backward,
];

class _MainAttendanceandhistoryscreenState
    extends State<MainAttendanceandhistoryscreen> {
  @override
  Widget build(BuildContext context) {
    ScreenHeight = MediaQuery.of(context).size.width;
    ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            new Calendarandhistory(),
            new AttendanceScreen(),
            new Id(),
            //new Dashboardforuser(),
          ],
        ),
        bottomNavigationBar: Container(
            height: 70,
            margin: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 15,
            ),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ]),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < navigationIcons.length;
                      i++) ...<Expanded>{
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = i;
                              });
                            },
                            child: Container(
                              height: ScreenHeight,
                              width: ScreenWidth,
                              color: Colors.white,
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Icon(
                                      navigationIcons[i],
                                      color: i == currentIndex
                                          ? primarycolor
                                          : Colors.black54,
                                      size: i == currentIndex ? 30 : 26,
                                    ),
                                    i == currentIndex
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            width: 24,
                                            height: 3,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1)),
                                              color: primarycolor,
                                            ))
                                        : const SizedBox()
                                  ])),
                            )))
                  }
                ],
              ),
            )));
  }
}
