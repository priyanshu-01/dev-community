import 'package:dsc_projects/pages/Home/post.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Post(),
      ),
    );
  }
}
