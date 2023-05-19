import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'StudentUserupdate.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  // to get all the documents in collection
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('Tbl_Student_User').snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('Tbl_Student_User');
  Future<void> deleteUser(id) {
    print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> studentsStream =
        FirebaseFirestore.instance.collection('Tbl_Student_User').snapshots();
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
                            label: Text('Std Id',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                          label: Text('Point Id',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                color: const Color(0xff000000),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        DataColumn(
                            label: Text('Full Name',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Contact No',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Email',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Address',
                                style: TextStyle(
                                  fontFamily: 'Segoe UI',
                                  fontSize: 20,
                                  color: const Color(0xff000000),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                ))),
                        DataColumn(
                            label: Text('Action',
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
                              DataCell(Text(storedocs[i]['Point_Id'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Container(
                                  child: Text(storedocs[i]['Std_FullName'],
                                      style: const TextStyle(fontSize: 18.0)))),
                              DataCell(Text(storedocs[i]['Std_Contact_No'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Text(storedocs[i]['Email'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(Text(storedocs[i]['Std_Address'],
                                  style: const TextStyle(fontSize: 18.0))),
                              DataCell(
                                Container(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  // to autofill the user information which we are updating
                                                  UpdateStudentPage(
                                                      id: storedocs[i]['id']),
                                            ),
                                          ),
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            {deleteUser(storedocs[i]['id'])},
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
