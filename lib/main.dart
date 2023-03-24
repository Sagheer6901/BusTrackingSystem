import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: unused_element
// making an instance for authentication
final FirebaseAuth _auth = FirebaseAuth.instance;

void main() async {
  // to fetch data
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
