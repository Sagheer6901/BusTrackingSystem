import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../Dashboards/Dashboardforuser.dart';
import '../forGlobals.dart' as globals;
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerid = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  String gstudentid = globals.studentId;
  late String semester = "";

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('Tbl_Fees_Status');

  String imageUrl = '';
  void showToast() {
    Fluttertoast.showToast(
        msg: "Image Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffafdceb),
      appBar: AppBar(
        backgroundColor: const Color(0xffafdceb),
        title: const Text('Upload Your Fee Voucher ',
            style: TextStyle(color: Colors.black, fontSize: 25)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
          onPressed: () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => Dashboardforuser())),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                    const InputDecoration(hintText: 'Enter Your Semester'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Semester';
                  }
                  return null;
                },
                onEditingComplete: () => semester = _controllerName.text,
              ),
              TextFormField(
                initialValue: gstudentid,
                readOnly: true,
                decoration: const InputDecoration(hintText: 'Enter Your Id'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Id';
                  }
                  return null;
                },
              ),
              Align(
                alignment: const Alignment(0.020, 0.907),
                child: IconButton(
                    autofocus: false,
                    // alignment: Alignment.bottomLeft,
                    iconSize: 80,
                    onPressed: () async {
                      /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */
                      /*Step 1:Pick image*/
                      //Install image_picker
                      //Import the corresponding library

                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      print('${file?.path}');

                      if (file == null) return;
                      //Import dart:core
                      final now = DateTime.now();
                      String properdate = now.year.toString() +
                          '-' +
                          now.month.toString() +
                          '-' +
                          now.day.toString();

                      /*Step 2: Upload to Firebase storage*/
                      //Install firebase_storage
                      //Import the library

                      //Get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('Images');

                      //Create a reference for the image to be stored
                      Reference referenceImageToUpload = referenceDirImages
                          .child('IMG-$gstudentid.$semester.$properdate');

                      //Handle errors/success
                      try {
                        //Store the file
                        await referenceImageToUpload.putFile(File(file.path));
                        //Success: get the download URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        //Some error occurred
                      }
                    },
                    icon: const Icon(Icons.camera_alt)),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 150, left: 30, right: 30),
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () async {
                        if (imageUrl.isNotEmpty) {
                          showToast();
                        }

                        if (key.currentState!.validate()) {
                          String Semester_Name = _controllerName.text;
                          String Student_Id = _controllerid.text;

                          //Create a Map of data
                          Map<String, String> dataToSend = {
                            'Semester_No': Semester_Name,
                            'Std_Id': gstudentid,
                            'ImageUrl': imageUrl,
                            'Status': 'Paid'
                          };

                          //  Add a new item
                          _reference.add(dataToSend);
                        }
                      },
                      child: const Text('Submit',
                          style: TextStyle(
                            color: Colors.black,
                            backgroundColor: Colors.white,
                          )))),
              Container(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  alignment: Alignment.bottomCenter,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Dashboardforuser()));
                          },
                          child: const Text('Go Back',
                              style: TextStyle(color: Colors.black))))),
            ],
          ),
        ),
      ),
    );
  }
}
