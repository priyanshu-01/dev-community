// import 'package:dsc_projects/pages/VisitProfile/visitProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../mainPage.dart';

class TopSection extends StatelessWidget {
  final doc;
  TopSection({this.doc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              // pageKey.currentState.setState(() {
              //   visitProfileUserId = doc.data()['uid'];
              //   currentPage = pages.VisitProfile;
              // });
            },
            child: Row(
              children: <Widget>[
                (doc.data()['myImageURL'] != null)
                    ? Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  new NetworkImage(doc.data()['myImageURL'])),
                        ),
                      )
                    : Container(
                        height: 45.0,
                        width: 45.0,
                      ),
                // ),),
                new SizedBox(
                  width: 10.0,
                ),
                new Text(
                  (doc.data()['name'] != null) ? doc.data()['name'] : "null",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 2.0, vertical: 15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.data()['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Text(
                    doc.data()['description'],
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
