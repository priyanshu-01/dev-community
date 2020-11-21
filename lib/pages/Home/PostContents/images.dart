import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  final doc;
  Images({this.doc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Image.network(
        doc.data()['images'],
        fit: BoxFit.cover,
      ),
    );
  }
}
