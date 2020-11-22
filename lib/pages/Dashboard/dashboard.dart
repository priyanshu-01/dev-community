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
            color: Colors.white,
            child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
                    Container(
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 20, 20, 10),
                                child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                firestore.imageURL)))),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 5, 0, 5),
                                    child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                          Container(
                                            child: Text(firestore.name,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          Divider(
                                              color: Colors.black, endIndent: 70),
                                          Container(
                                              width: 300,
                                              child: Text(
                                                  'This is my wonderful bio This is my wonderful bio This is my wonderful bio ')),
                                        ])),
                                  ),
                                ],
                              ),
                            ])),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                            Text('Posts',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ])),
                    ),
                    Container(
                        margin: EdgeInsets.all(8),
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
                                      padding: EdgeInsets.all(4),
                                      child:Post(doc: postDocumentSnapshots[a])
                                          );
                                })),
                  ])
        ),
        floatingActionButton: FloatingActionButton( onPressed: (){
          GoogleAuthentication().signOutGoogle();
        },
        child: Icon(Icons.logout))
    );
    

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
