import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Buttonsforadmindashboard/ManageDriverScreens/managedriver.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:firstapp/forGlobals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class updatedriver extends StatefulWidget {
  final String id;
  const updatedriver({Key? key, required this.id}) : super(key: key);

  @override
  _updatedriverState createState() => _updatedriverState();
}

class _updatedriverState extends State<updatedriver> {
  final _formKey = GlobalKey<FormState>();

  var modddate = DateFormat('d MMMM yyyy').format(DateTime.now());

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('Tbl_Driver_User');

  Future<void> updateUser(id, point_id, contactno, vehregno, vehtype, moddate) {
    return students
        .doc(id)
        .update({
          'Driver_Contact_No': contactno,
          'Point_Id': point_id,
          'Driver_Veh_Reg_No': vehregno,
          'Driver_Vehicle_Type': vehtype,
          'Modified_Date': modddate
        })
        .then((value) => print("Driver Updated"))
        .catchError((error) => print("Failed to update driver: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        title: const Text("Driver Update",
            style: TextStyle(color: Colors.black, fontSize: 25)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Dashboardforadmin())),
        ),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Tbl_Driver_User')
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
              var id = data!['Driver_Id'];
              var point_id = data['Point_Id'];
              var contactno = data['Driver_Contact_No'];
              var vehregno = data['Driver_Veh_Reg_No'];
              var vehtype = data['Driver_Vehicle_Type'];
              var modddate = data['Modified_Date'];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: contactno,
                        autofocus: false,
                        onChanged: (value) => contactno = value,
                        decoration: const InputDecoration(
                          labelText: 'Contact No',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Contact Info';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: point_id,
                        autofocus: false,
                        onChanged: (value) => point_id = value,
                        decoration: const InputDecoration(
                          labelText: 'Point Id',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Contact Info';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: vehregno,
                        autofocus: false,
                        onChanged: (value) => vehregno = value,
                        decoration: const InputDecoration(
                          labelText: 'Vehicle Registration No: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Registration Number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: vehtype,
                        autofocus: false,
                        onChanged: (value) => vehtype = value,
                        decoration: const InputDecoration(
                          labelText: 'Veh Type: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Vehicle Type';
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
                              updateUser(widget.id, point_id, contactno,
                                  vehregno, vehtype, modddate);
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
                                    builder: (context) => const managedriver()))
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
