import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/Buttonsforadmindashboard/ManageUserScreens/usersdatafetch.dart';
import 'package:firstapp/Buttonsforadmindashboard/ManageeRoutes.dart/MainRoute.dart';
import 'package:firstapp/Dashboards/Dashboardforadmin.dart';
import 'package:flutter/material.dart';

class updateroute extends StatefulWidget {
  final String id;
  const updateroute({Key? key, required this.id}) : super(key: key);

  @override
  _updaterouteState createState() => _updaterouteState();
}

class _updaterouteState extends State<updateroute> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('Tbl_Routes_Admin');

  Future<void> updateUser(id, pointid, route) {
    return students
        .doc(id)
        .update({
          'Route': route,
          'Point_Id': pointid,
        })
        .then((value) => print("Route Updated"))
        .catchError((error) => print("Failed to update route: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        title: const Text("Update Routes",
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
                .collection('Tbl_Routes_Admin')
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
              var id = data!['Point_Id'];
              var pointid = data['Point_Id'];
              String route = data['Routes'];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: pointid,
                        autofocus: false,
                        onChanged: (value) => pointid = value,
                        decoration: const InputDecoration(
                          labelText: 'Point Number',
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
                        initialValue: route,
                        autofocus: false,
                        onChanged: (value) => route = value,
                        decoration: const InputDecoration(
                          labelText: 'Enter Route: ',
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Route';
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
                              updateUser(widget.id, pointid, route);
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
                                    builder: (context) => const manageroute()))
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          child: const Text(
                            'Back',
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
