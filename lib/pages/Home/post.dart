import 'package:dsc_projects/pages/Home/PostContents/images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'PostContents/bottomSection.dart';
import 'PostContents/topSection.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    // var deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TopSection(),
        Images(),
        BottomSection(),
      ],
    );
  }
}
