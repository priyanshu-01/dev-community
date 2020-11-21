import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  String uid = 'uid';
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
