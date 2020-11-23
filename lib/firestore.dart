import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/services/authHandler.dart';

class FirestoreFunctions {
  String name;
  String uid;
  String email;
  String imageURL;

  FirestoreFunctions({this.name, this.uid, this.email, this.imageURL});
  likePost(DocumentSnapshot doc) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(doc.id)
        .update({'likes.$uid': true});
  }

  unlikePost(DocumentSnapshot doc) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(doc.id)
        .update({'likes.$uid': null});
  }

  addBio(String bio) async {
    await FirebaseFirestore.instance
        .collection('users google')
        .doc(userFirebaseDocumentId)
        .update({'bio': bio});
  }
  deletePost(DocumentSnapshot doc) async {
    FirebaseFirestore.instance.collection("posts").doc(doc.id).delete();
  }
}
