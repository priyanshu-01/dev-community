import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopSection extends StatelessWidget {
  final doc;
  TopSection({this.doc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(doc.data()['myImageURL'])),
                    ),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Text(
                    doc.data()['name'],
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w700),
                  )
                ],
              ),
              new IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: null,
              )
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Container(
              // color: Colors.blue[100],
              // height: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.data()['title'],
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                  ),
                  Text(doc.data()['description']
                      // 'Made mobile and web for DSC members to showcase their work and achievements to the team'
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
