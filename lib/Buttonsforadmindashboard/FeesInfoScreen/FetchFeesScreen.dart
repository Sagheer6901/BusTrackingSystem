import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class fetchfeesStudentPage extends StatefulWidget {
  const fetchfeesStudentPage({Key? key}) : super(key: key);

  @override
  fetchfeesStudentPageState createState() => fetchfeesStudentPageState();
}

class fetchfeesStudentPageState extends State<fetchfeesStudentPage> {
  // to get all the documents in collection
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Tbl_Fees_Status').snapshots();
  // final List<int> shades = [100, 200, 300, 400, 500, 600, 700, 800, 900];
  final ScrollController _horizontal = ScrollController(),
      _vertical = ScrollController();
  @override
  Widget build(BuildContext context) {
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
                            label: Text('Std_Id',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Semester',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Image URL',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Status',
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
                              DataCell(Text(storedocs[i]['Std_Id'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Text(storedocs[i]['Semester_No'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Container(
                                  child: Text(storedocs[i]['ImageUrl'],
                                      style: const TextStyle(fontSize: 18.0)))),
                              DataCell(Text(storedocs[i]['Status'],
                                  style: const TextStyle(fontSize: 18.0))),
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
  }
}



















          // return Container(
          //   height: 550,
          //   width: 400,
          //   margin:
          //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          //   child: SingleChildScrollView(
          //     physics: const BouncingScrollPhysics(
          //         parent: AlwaysScrollableScrollPhysics()),
          //     // physics: const  BouncingScrollPhysics(),
          //     dragStartBehavior: DragStartBehavior.start,
          //     scrollDirection: Axis.horizontal,
          //     controller: ScrollController(initialScrollOffset: 50.0),
          //     child: Table(
          //       border: TableBorder.all(),
          //       columnWidths: const {
          //         2: FixedColumnWidth(200),
          //       },
          //       defaultColumnWidth: const IntrinsicColumnWidth(),
          //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //       children: [
          //         TableRow(
          //           children: [
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Scrollbar(
          //                   controller: _vertical,
          //                   child: Text(
          //                     ' Std Id ',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Scrollbar(
          //                   controller: _vertical,
          //                   child: Text(
          //                     ' Semester No',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Scrollbar(
          //                   controller: _vertical,
          //                   child: Text(
          //                     ' Image Url',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Scrollbar(
          //                   controller: _vertical,
          //                   child: Text(
          //                     ' Status',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         for (var i = 0; i < storedocs.length; i++) ...[
          //           TableRow(
          //             children: [
          //               TableCell(
          //                 child: Scrollbar(
          //                     controller: _vertical,
          //                     child: Text(storedocs[i]['Std_Id'],
          //                         style: const TextStyle(fontSize: 18.0))),
          //               ),
          //               TableCell(
          //                 child: Scrollbar(
          //                     controller: _vertical,
          //                     child: Text(storedocs[i]['Semester_No'],
          //                         style: const TextStyle(fontSize: 18.0))),
          //               ),
          //               TableCell(
          //                 child: Scrollbar(
          //                     controller: _vertical,
          //                     child: Text(storedocs[i]['ImageUrl'],
          //                         style: const TextStyle(fontSize: 18.0))),
          //               ),
          //               TableCell(
          //                 child: Scrollbar(
          //                     controller: _vertical,
          //                     child: Text(storedocs[i]['Status'],
          //                         style: const TextStyle(fontSize: 18.0))),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ],
          //     ),
          //   ),
          // );
          
//         });
//   }
// }
