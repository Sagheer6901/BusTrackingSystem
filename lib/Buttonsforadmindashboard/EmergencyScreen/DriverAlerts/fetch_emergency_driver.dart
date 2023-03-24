import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class fetchemergencydriver extends StatefulWidget {
  const fetchemergencydriver({Key? key}) : super(key: key);

  @override
  fetchemergencydriverState createState() => fetchemergencydriverState();
}

class fetchemergencydriverState extends State<fetchemergencydriver> {
  // to get all the documents in collection
  final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
      .collection('Tbl_EmergencyAlert_driver')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> studentsStream = FirebaseFirestore.instance
        .collection('Tbl_EmergencyAlert_driver')
        .snapshots();
    final List<int> shades = [100, 200, 300, 400, 500, 600, 700, 800, 900];
    final ScrollController _horizontal = ScrollController(),
        _vertical = ScrollController();

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

          return SizedBox(
            height: 600,
            width: 500,
            child: Scrollbar(
              controller: _vertical,
              thumbVisibility: true,
              trackVisibility: true,
              child: Scrollbar(
                controller: _horizontal,
                thumbVisibility: true,
                trackVisibility: true,
                notificationPredicate: (notif) => notif.depth == 1,
                child: SingleChildScrollView(
                  controller: _vertical,
                  child: SingleChildScrollView(
                    controller: _horizontal,
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xf00652c5)),
                      columns: const <DataColumn>[
                        DataColumn(
                            label: Text('Driver Id',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Emergency Alert Message',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Emergency Message Date',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ],
                      rows: [
                        for (var i = 0; i < storedocs.length; i++) ...[
                          DataRow(
                            cells: [
                              DataCell(Text(storedocs[i]['Driver_Id'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Text(storedocs[i]['Emergency'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Container(
                                  child: Text(storedocs[i]['Emergency_Date'],
                                      style: const TextStyle(fontSize: 18.0)))),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
    // to fetch realtime database information
  }
}
