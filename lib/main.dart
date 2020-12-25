import 'package:dsc_projects/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart' as fs;

List userData = List();
fs.Firestore store;

// QueryDocumentSnapshot a;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); //must
  // await firebase.initializeApp();
  // initializeApp(
  //     apiKey: "AIzaSyAL0RjlkUgWcKa_Psm48fyRA_GCLtkeZIA",
  //     authDomain: "dsc-projects-6a131.firebaseapp.com",
  //     databaseURL: "https://dsc-projects-6a131.firebaseio.com",
  //     projectId: "dsc-projects-6a131",
  //     storageBucket: "dsc-projects-6a131.appspot.com",
  //     messagingSenderId: "641607442926",
  //     appId: "1:641607442926:web:5f756949292de61f76aeff",
  //     measurementId: "G-LS80DQZSPJ");
  store = firestore();
  runApp(new MyApp());
  await store.collection('userData').get().then((value) {
    value.docs.forEach((element) {
      userData.add(element.data());
    });
  });
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
        textTheme: GoogleFonts.ubuntuTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // home: new AuthHandler(),
      // home: Hi(),
      home: MainPageWithAppBar(),
    );
  }
}

class Hi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("helooo"),
      ),
    );
  }
}
