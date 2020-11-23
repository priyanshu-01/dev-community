import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  final doc;
  Images({this.doc});

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0),),
          child: Image.network(doc.data()['images'],
        // doc.data()['images'],
        fit: BoxFit.fitHeight,
        height: 400,
      ),
    );
  }
}
