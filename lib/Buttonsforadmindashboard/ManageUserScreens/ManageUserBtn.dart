import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FetchUser extends StatefulWidget {
  const FetchUser({super.key});

  @override
  State<FetchUser> createState() => _FetchUserState();
}

class Student {
  late String Std_FullName;
  late String Std_Id;
  late String Std_Contact_No;
  late String Std_Address;

  Student(
      {this.Std_Id = '',
      required this.Std_FullName,
      required this.Std_Address,
      required this.Std_Contact_No});

  Map<String, dynamic> toJson() => {
        'Std_Id': Std_Id,
        'Std_FullName': Std_FullName,
        'Std_Address': Std_Address,
        'Std_Contact_No': Std_Contact_No
      };
  static Student fromJson(Map<String, dynamic> json) => Student(
      Std_Id: json['Std_Id'],
      Std_FullName: json['Std_FullName'],
      Std_Address: json['Std_Address'],
      Std_Contact_No: json['Std_Contact_No']);
}

Widget buildStudent(Student stud) => ListTile(
    leading: CircleAvatar(child: Text('${stud.Std_Id}')),
    title: Text(stud.Std_Contact_No),
    subtitle: Text(stud.Std_Address));

Stream<List<Student>> readUsers() => FirebaseFirestore.instance
    .collection("Tbl_Student_User")
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());

class _FetchUserState extends State<FetchUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdcd3d3),
      appBar: AppBar(
          backgroundColor: const Color(0xffdcd3d3),
          title: const Text('All Students')),
      body: StreamBuilder(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something Went Wrong! ${snapshot.error}");
          } else if (snapshot.hasData) {
            final stud = snapshot.data!;

            return ListView(
              children: stud.map(buildStudent).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
