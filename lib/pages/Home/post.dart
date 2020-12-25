import 'package:dsc_projects/pages/Home/PostContents/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'PostContents/bottomSection.dart';
import 'PostContents/topSection.dart';

class Post extends StatefulWidget {
  final doc;
  Post({this.doc});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    // var deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TopSection(
              doc: widget.doc,
            ),
            (widget.doc.data()['images'] != null &&
                    widget.doc.data()['images'] != [])
                ? Images(
                    doc: widget.doc,
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            BottomSection(
              doc: widget.doc,
            ),
          ],
        ),
      ),
    );
  }
}
