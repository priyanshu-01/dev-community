import 'package:firebase_auth/firebase_auth.dart';
import 'authHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnonymousAuthentication {
  Future<void> createAnonymousUser() async {
    await FirebaseFirestore.instance.collection('users anonymous').add({
      'uid': uid,
      'name': name,
      'imageUrl': imageUrl,
    }).then((value) {
      value.get().then((value) => userFirebaseDocumentMap = value.data());
      userFirebaseDocumentId = value.id;
    });
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOutAnonymous() async {
    try {
      print('signoutAnonymous success');
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
