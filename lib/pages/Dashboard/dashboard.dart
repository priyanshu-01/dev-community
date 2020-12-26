import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_projects/pages/Dashboard/animatedList.dart';
import 'package:dsc_projects/pages/Dashboard/bio.dart';
import 'package:dsc_projects/pages/Dashboard/updatebio.dart';
import 'package:dsc_projects/pages/Home/post.dart';
import 'package:dsc_projects/services/authHandler.dart';
import 'package:flutter/material.dart';
import 'package:dsc_projects/mainPage.dart';
import 'package:dsc_projects/services/authService.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Alert/rflutter_alert.dart';

List postDocumentSnapshots = List();
GlobalKey myBioKey = GlobalKey();

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
                                    myFirestore.imageURL,
                                  )))),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Container(
                                  child: Text(myFirestore.name,
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
                                Bio(),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateBio()),
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      // color: Colors.black,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(6.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 20.0),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  'Edit Bio',
                                                  style: GoogleFonts.ubuntu(
                                                      color: Colors.white),
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
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
                  child: (postDocumentSnapshots.isEmpty)
                      ? NoPostsYet()
                      : MyAnimatedList()
                  // ListView.builder(
                  //     // crossAxisCount: 3,
                  //     addAutomaticKeepAlives: true,
                  // shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: postDocumentSnapshots.length,
                  //     itemBuilder: (context, int a) {
                  //       return Card(
                  //           color: Colors.grey[900],
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(0.0),
                  //             child: Column(children: <Widget>[
                  //               Post(doc: postDocumentSnapshots[a]),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   Alert(
                  //                       context: context,
                  //                       title: 'Delete this post?',
                  //                       style: AlertStyle(
                  //                         backgroundColor: Colors.black,
                  //                         titleStyle: GoogleFonts.ubuntu(
                  //                             color: Colors.white),
                  //                       ),
                  //                       buttons: [
                  //                         DialogButton(
                  //                             color: Colors.white,
                  //                             child: Text('Yes'),
                  //                             onPressed: () {
                  //                               Navigator.pop(context);
                  //                               firestore.deletePost(
                  //                                   postDocumentSnapshots[
                  //                                       a]);
                  //                             }),
                  //                         DialogButton(
                  //                             color: Colors.white,
                  //                             child: Text('No'),
                  //                             onPressed: null)
                  //                       ]).show();
                  //                 },
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.fromLTRB(
                  //                       0, 0, 0, 15),
                  //                   child: Icon(
                  //                     Icons.delete,
                  //                     size: 30,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               )
                  //             ]),
                  //           ));
                  //     })
                  ),
            ])),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              GoogleAuthentication().signOutGoogle();
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
            )));
  }
}

Future<void> getPosts() async {
  await FirebaseFirestore.instance
      .collection('posts')
      .where('uid', isEqualTo: myFirestore.uid)
      .get()
      .then((value) => {postDocumentSnapshots = value.docs});
}

class NoPostsYet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        child: Text(
          '\' Not Posted Yet \'',
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Bio extends StatefulWidget {
  Bio() : super(key: myBioKey);
  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        child: Text(
          userFirebaseDocumentMap['bio'],
          style: TextStyle(color: Colors.white, fontSize: 16),
        ));
    ;
  }
}
