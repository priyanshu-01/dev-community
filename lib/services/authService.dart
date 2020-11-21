import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'authHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoogleAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) return false;

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    var authResult = await _auth.signInWithCredential(credential);

    if (authResult.user == null) return false;

    print("signInWithGoogle succeeded");

    return true;
  }

  Future<void> signOutGoogle() async {
    print("signOutWithGoogle succeeded");
    await _auth.signOut();
    // whenComplete(() => check = signInMethod.anonymous);
    checkSignInMethod = signInMethod.anonymous;
  }

  Future<void> createGoogleUser() async {
    await FirebaseFirestore.instance.collection('users google').add({
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    }).then((value) {
      value.get().then((value) => userFirebaseDocumentMap = value.data());
      userFirebaseDocumentId = value.id;
    });
  }
}
