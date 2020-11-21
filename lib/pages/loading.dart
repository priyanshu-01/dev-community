import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 40.0,
          ),
          SpinKitThreeBounce(
            color: Colors.black,
            size: 20.0,
            duration: Duration(milliseconds: 700),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      )),
    );
  }
}
