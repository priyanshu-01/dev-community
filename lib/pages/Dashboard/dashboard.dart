import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/pages/Dashboard/bio.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/services/authHandler.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/services/authService.dart';

List postDocumentSnapshots = List();
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  bool _postOpened = false;
  @override
  void initState() {
    getPosts().whenComplete(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.grey[800],
            child:
                ListView(physics: BouncingScrollPhysics(), children: <Widget>[
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                      image:
                                          NetworkImage(firestore.imageURL,)))),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                    Container(
                                      child: Text(firestore.name,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color:Colors.white,
                                          )),
                                    ),
                                    Divider(color: Colors.white, endIndent: 60,indent: 60,),
                                    Container(
                                        width: 300,
                                        child: Text(
                                          userFirebaseDocumentMap['bio'],
                                          style: TextStyle(color:Colors.white,fontSize: 16),
                                          textAlign: TextAlign.center,
                                        )),
                                  ])),
                            ),
                          ],
                        ),
                      ])),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
                        child: Divider(
                          thickness: .3,
                          color: Colors.white, 
                          indent: 8,
                          endIndent: 8,
                        ),
                      ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Text('Posts',
                          style: TextStyle(
                            fontSize: 25,
                            color:Colors.white
                          )),
                    ])),
              ),
              Container(
                  child: (postDocumentSnapshots.isEmpty)
                      ? NoPostsYet()
                      : ListView.builder(
                          // crossAxisCount: 3,
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postDocumentSnapshots.length,
                          itemBuilder: (context, int a) {
                            return Container(
                                child: Post(doc: postDocumentSnapshots[a]));
                          })),
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
            onPressed: () {
              GoogleAuthentication().signOutGoogle();
            },
            child: Icon(Icons.logout,color: Colors.black,)));
  }
}

Future<void> getPosts() async {
  await FirebaseFirestore.instance
      .collection('posts')
      .where('uid', isEqualTo: firestore.uid)
      .get()
      .then((value) => {postDocumentSnapshots = value.docs});
}

class NoPostsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('NO posts yet'),
    );
  }
}
