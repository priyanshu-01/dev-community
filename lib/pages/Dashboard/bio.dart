import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/services/authHandler.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/authHandler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Bio extends StatelessWidget {
  final TextEditingController userbio = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  )),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 3,
                child: Container(
                  child: Text(
                    'DEV COMMUNITY',
                    style:
                        GoogleFonts.raleway(color: Colors.black, fontSize: 25),
                  ),
                ),
              ),
              Flexible(flex: 3, child: Container()),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(firestore.imageURL),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          firestore.name,
                          style: GoogleFonts.ubuntu(fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    child: TextField(
                      controller: userbio,
                      decoration: InputDecoration(hintText: 'Add You Bio'),
                    ),
                  ),
                ),
              ),
              Flexible(
                  flex: 2,
                  child: Container(
                      // color: Colors.black,
                      )),
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
                    horizontal: 25.0, vertical: 10.0),
                child: Text(
                  'Next',
                  style: GoogleFonts.ubuntu(
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
        bioOrMainPageWidgetKey.currentState.setState(() {});
      },
    );
  }
}
