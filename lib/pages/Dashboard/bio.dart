import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bio extends StatelessWidget {
  final TextEditingController userbio=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children:<Widget>[
            Image.asset('assets/images/logo.png'),
            Text('DEV COMMUNITY',
            style: GoogleFonts.raleway(color: Colors.black,fontSize: 25),
            ),
            TextField(
              controller: userbio,
              decoration: InputDecoration(
                hintText: 'Add You Bio'
              ),
            ),
            RaisedButton(
              child: Text('Next'),
              onPressed: (){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => MainPageWithAppBar()),
                );
              },
            )
          ]
        ),
      ),
    );
  }
}
