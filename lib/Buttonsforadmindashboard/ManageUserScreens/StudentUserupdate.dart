import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Buttonsforadmindashboard/ManageUserScreens/manageuser.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var modddate = DateFormat('d MMMM yyyy').format(DateTime.now());

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('Tbl_Student_User');
  Future<void> updateUser(
      id, emailaddress, pointid, contactno, address, moddate) {
    return students
        .doc(id)
        .update({
          'Email': emailaddress,
          'Point_Id': pointid,
          'Std_Contact_No': contactno,
          'Std_Address': address,
          'Modified_Date': modddate,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        title: const Text("Update Student",
            style: TextStyle(color: Colors.black, fontSize: 25)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboardforadmin())),
        ),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Tbl_Student_User')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var id = data!['Std_Id'];
              var emailaddress = data['Email'];
              var pointid = data['Point_Id'];
              var contactno = data['Std_Contact_No'];
              var address = data['Std_Address'];
              var modddate = data['Modified_Date'];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: emailaddress,
                        autofocus: false,
                        onChanged: (value) => emailaddress = value,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          } else if (!value.contains('.com')) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: pointid,
                        autofocus: false,
                        onChanged: (value) => pointid = value,
                        decoration: const InputDecoration(
                          labelText: 'Point Id: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Point Id';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: contactno,
                        autofocus: false,
                        onChanged: (value) => contactno = value,
                        decoration: const InputDecoration(
                          labelText: 'Contact No: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Contact Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: address,
                        autofocus: false,
                        onChanged: (value) => address = value,
                        decoration: const InputDecoration(
                          labelText: 'Address: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Address';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              updateUser(
                                widget.id,
                                emailaddress,
                                pointid,
                                contactno,
                                address,
                                modddate,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()))
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: const Text(
                            'Go Back',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
