import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/pages/Dashboard/bio.dart';
import 'package:dsc_projects/pages/loading.dart';
import 'package:dsc_projects/services/authHandler.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

List userData = List();
QueryDocumentSnapshot a;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //must
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.collection('userData').get().then((value) {
    value.docs.forEach((element) {
      userData.add(element.data());
    });
  });

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.black,
          buttonColor: Colors.black,
          primaryIconTheme: IconThemeData(color: Colors.black),
          textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme,
        ),),
      home: new AuthHandler(),
      // home: Bio(),
    );
  }
}
