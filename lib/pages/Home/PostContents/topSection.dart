import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Container(
                    height: 45.0,
                    width: 45.0,
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
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w700,fontSize: 17,color: Colors.white),
                  )
                ],
              ),
            ],
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
                    style: GoogleFonts.roboto(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white),
                  ),
                  Text(doc.data()['description'],style: TextStyle(fontSize: 13,color: Colors.white),
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
