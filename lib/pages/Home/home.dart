import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/pages/Home/feed.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //  child: Post()

      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Container(
              child: Loading(),
            );
          else
            return ListView.builder(
              addAutomaticKeepAlives: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Post(doc: snapshot.data.docs[index]);
                // Text(snapshot.data.docs[index].data()['title']);
              },
            );
        },
      ),
      // child: Post(),
    );
  }
}
