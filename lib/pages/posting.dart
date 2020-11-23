import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Posting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.grey[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                  child: Image.asset('assets/images/applogo.png',color: Colors.white,scale: 1.5,),
                ),
                SpinKitWanderingCubes(
                  color: Colors.white,
                  size: 90.0,
                ),
                SizedBox(
                  height: 60.0,
                ),
                Text('Sharing to the Community...',
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 20
                    ))
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
