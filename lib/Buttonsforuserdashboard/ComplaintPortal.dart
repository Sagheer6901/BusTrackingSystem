import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import '../Dashboards/Dashboardforuser.dart';
import '../forGlobals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComplaintPortal extends StatelessWidget {
  CollectionReference ComplainPortal =
      FirebaseFirestore.instance.collection('Tbl_ComplaintPortal');

  void showToast() {
    Fluttertoast.showToast(
        msg: "Complain Sent Succesfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
  }

  late String complainMessage;

  ComplaintPortal({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffafdceb),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(size: 219.0, start: -13.0),
            Pin(size: 120.0, start: 89.0),
            child: const Text(
              '    COMPLAINT \n       PORTAL\n',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 30,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 100.0, end: 29.0),
            Pin(size: 100.0, start: 60.0),
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/userdashboardcomp.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(112.0),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 92.0, start: 25.0),
            Pin(size: 27.0, middle: 0.2809),
            child: const Text(
              'Student Id:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: Color(0xff000000),
                fontStyle: FontStyle.italic,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 130.0, start: 120.0),
            Pin(size: 33.0, middle: 0.2701),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.circular(29.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: TextFormField(
                initialValue: '   ${globals.studentId}',
                readOnly: true,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 140.0, end: 200.0),
            Pin(size: 27.0, middle: 0.3516),
            child: const Text(
              'Complain Message:',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 20,
                color: const Color(0xff000000),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
              softWrap: false,
            ),
          ),
          Pinned.fromPins(
              Pin(start: 2.0, end: 28.0), Pin(size: 177.0, middle: 0.4273),
              child: Container(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) {
                          // ASSIGNING VALUE ENTERED IN TEXT FIELD TO STD_FIREBASE
                          complainMessage = value;
                        },
                        maxLines: 5,
                        minLines: 1,
                        decoration: const InputDecoration(
                            //  labelText: 'Complain Box',
                            hintText: 'Enter Your Complain Here',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            ))),
                      ),
                    ],
                  ))),
          Align(
            alignment: const Alignment(0.0, 0.264),
            child: Container(
              width: 184.0,
              height: 55.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(29.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
              child: FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: Colors.white,
                onPressed: () async {
                  await ComplainPortal.add({
                    'Std_Id': globals.studentId,
                    'Complain': complainMessage,
                    'Complain_Date': DateFormat().format(DateTime.now())

                    // ignore: avoid_print
                  }).then((value) => print('Complain Added'));
                  showToast();
                },
                label: const Text(
                  'Submit',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 23,
                    color: const Color(0xff010000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.004, 0.487),
            child: Container(
              width: 163.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          ),
          Container(
              alignment: const Alignment(0.100, 0.473),
              child: SizedBox(
                  width: 81.0,
                  height: 27.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboardforuser()));
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
                  )))
        ],
      ),
    );
  }
}
