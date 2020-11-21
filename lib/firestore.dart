import 'package:cloud_firestore/cloud_firestore.dart';

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
}
