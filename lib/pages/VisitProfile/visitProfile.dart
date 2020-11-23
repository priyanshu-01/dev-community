import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/mainPage.dart';

DocumentSnapshot visitProfileUser;
String visitProfileUserId;
GlobalKey backButtonKey = new GlobalKey();

class VisitProfile extends StatefulWidget {
  @override
  _VisitProfileState createState() => _VisitProfileState();
}

class _VisitProfileState extends State<VisitProfile> {
  List visitedProfilePostsDocumentSnapshotList = [];
  @override
  void initState() {
    if (visitProfileUser != null &&
        visitProfileUser.data()['uid'] == visitProfileUserId) {
      getPosts().whenComplete(() => setState(() {}));
    } else {
      getUserData().whenComplete(() => {
            // backButtonKey.currentState.setState(() {}),
            getPosts().whenComplete(() => setState(() {}))
          });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (visitProfileUser != null &&
            visitProfileUser.data()['uid'] == visitProfileUserId)
        ? Container(
            color: Colors.grey[800],
            child:
                ListView(physics: BouncingScrollPhysics(), children: <Widget>[
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                      child: Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    visitProfileUser.data()['imageUrl'],
                                  )))),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                          child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Container(
                                  child: Text(visitProfileUser.data()['name'],
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      )),
                                ),
                                Divider(
                                  color: Colors.white,
                                  endIndent: 70,
                                  indent: 2,
                                ),
                                Container(
                                    width: 300,
                                    child: Text(
                                      visitProfileUser.data()['bio'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ])),
                        ),
                      ],
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                child: Divider(
                  thickness: .2,
                  color: Colors.white,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Posts',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ])),
              ),
              Container(
                  child: (visitedProfilePostsDocumentSnapshotList.isEmpty)
                      ? NoPostsYet()
                      : ListView.builder(
                          // crossAxisCount: 3,
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              visitedProfilePostsDocumentSnapshotList.length,
                          itemBuilder: (context, int a) {
                            return Card(
                                color: Colors.grey[900],
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(children: <Widget>[
                                    Post(
                                        doc:
                                            visitedProfilePostsDocumentSnapshotList[
                                                a]),
                                  ]),
                                ));
                          })),
            ]))
        : Loading();
  }

  Future<void> getPosts() async {
    await FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: visitProfileUserId)
        .get()
        .then(
            (value) => {visitedProfilePostsDocumentSnapshotList = value.docs});
  }

  Future<void> getUserData() async {
    await FirebaseFirestore.instance
        .collection('users google')
        .where('uid', isEqualTo: visitProfileUserId)
        .get()
        .then((value) => {visitProfileUser = value.docs[0]});
  }
}

class NoPostsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('NO posts yet'),
    );
  }
}

Widget backButtonBar() {
  return AppBar(
    backgroundColor: Colors.black,
    elevation: 2.0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: Container(
              width: 40,
              height: 40,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  pageKey.currentState.setState(() {
                    currentPage = pages.HomePage;
                  });
                },
              )),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    ),
    actions: <Widget>[],
  );
}
