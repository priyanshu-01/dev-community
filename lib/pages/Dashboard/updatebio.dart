import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/pages/Dashboard/dashboard.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/services/authHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/authHandler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dsc_projects/mainPage.dart';

class UpdateBio extends StatelessWidget {
  final TextEditingController userbio =
      TextEditingController(text: userFirebaseDocumentMap['bio']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar,
      body: Container(
        color: Colors.grey[900],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: CircleAvatar(
                  radius: 40.0,
                  // maxRadius: 75.0,
                  backgroundImage: NetworkImage(firestore.imageURL),
                ),
              ),
              Flexible(child: Container()),
              Flexible(
                child: Text(
                  firestore.name,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      controller: userbio,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Add Your Bio',
                          hintStyle: TextStyle(color: Colors.grey[500])),
                    ),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                  flex: 2,
                  child: MyNextButton(
                    userbio: userbio,
                  ))
            ]),
      ),
    );
  }
}

class MyNextButton extends StatefulWidget {
  final TextEditingController userbio;
  MyNextButton({this.userbio});
  @override
  _MyNextButtonState createState() => _MyNextButtonState();
}

class _MyNextButtonState extends State<MyNextButton> {
  bool _loading;
  @override
  void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(5.0)),
        child: (!_loading)
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 15.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 10.0),
                child: Container(
                  height: 20.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: SpinKitThreeBounce(
                          color: Colors.blue,
                          size: 20.0,
                          duration: Duration(milliseconds: 800),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      onTap: () async {
        setState(() {
          _loading = !_loading;
        });
        await firestore.addBio(widget.userbio.text);
        userFirebaseDocumentMap['bio'] = widget.userbio.text;
        myBioKey.currentState.setState(() {});
        Navigator.pop(context);
      },
    );
  }
}
