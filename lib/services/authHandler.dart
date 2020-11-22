import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/pages/Dashboard/bio.dart';
import 'package:dsc_projects/pages/Home/home.dart';
import 'package:dsc_projects/pages/loading.dart';
import 'package:dsc_projects/services/anon.dart';
import 'package:dsc_projects/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firestore.dart';

String name, email, imageUrl, uid;
String userFirebaseDocumentId;
Map userFirebaseDocumentMap;
enum signInMethod { google, anonymous }
var checkSignInMethod = signInMethod.anonymous;
enum status { signedIn, notSignedIn }
var signInStatus = status.notSignedIn;
AsyncSnapshot userAuthenticationSnapshot;

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          userAuthenticationSnapshot = snapshot;
          if (snapshot.connectionState == ConnectionState.waiting)
            return Loading(); //loading page
          else if (snapshot.hasData && snapshot.data != null) {
            signInStatus = status.signedIn;
            if (snapshot.data.isAnonymous) {
              checkSignInMethod = signInMethod.anonymous;
              uid = snapshot.data.uid;
              return fetchFutureAnonymous();
            } else {
              checkSignInMethod = signInMethod.google;
              name = snapshot.data.displayName;
              email = snapshot.data.email;
              imageUrl = snapshot.data.photoURL;
              uid = snapshot.data.uid;
              firestore = FirestoreFunctions(
                  email: email, imageURL: imageUrl, name: name, uid: uid);
              return fetchFutureGoogle();
            }
          } else
          // LoginPage
          {
            signInStatus = status.notSignedIn;
            return LoginPage();
          }
        });
  }
}

Widget fetchFutureAnonymous() {
  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance
        .collection('users anonymous')
        .where('uid', isEqualTo: uid)
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return Loading();
      else {
        if (snapshot.data.docs.length == 0) {
          AnonymousAuthentication().createAnonymousUser();
        } else {
          userFirebaseDocumentMap = snapshot.data.docs[0].data();
          userFirebaseDocumentId = snapshot.data.docs[0].id;
          name = userFirebaseDocumentMap['name'];
          imageUrl = userFirebaseDocumentMap['imageUrl'];
          // AnonymousAuthentication().activate();
        }
        return MainPageWithAppBar();
      }
    },
  );
}

Widget fetchFutureGoogle() {
  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance
        .collection('users google')
        .where('uid', isEqualTo: uid)
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting)
        return Loading();
      else {
        if (snapshot.data.docs.length == 0) {
          GoogleAuthentication().createGoogleUser();
        } else {
          userFirebaseDocumentMap = snapshot.data.docs[0].data();
          userFirebaseDocumentId = snapshot.data.docs[0].id;
          name = userFirebaseDocumentMap['name'];
          imageUrl = userFirebaseDocumentMap['imageUrl'];
        }
        return MainPageWithAppBar();
      }
    },
  );
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(image: AssetImage('assets/images/logo.png')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Container(
                child: Text(
                  'DEV COMMUNITY',
                  style: GoogleFonts.raleway(color: Colors.black,fontSize: 30),
                  maxLines: 1,
                ),
            ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                child: SignInButton(
                 Buttons.GoogleDark,
                  text: "Sign up with Google",
                   onPressed: () {
                     GoogleAuthentication().signInWithGoogle();
                   },
                  ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
