import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWork extends StatelessWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: TextField(
                controller: _title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
              child: TextField(
                controller: _description,
                decoration: InputDecoration(hintText: 'Description'),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              child: Text('Post'),
              onPressed: () {
                _title.clear();
                _description.clear();
                FirebaseFirestore.instance.collection('posts').add({
                  'title': _title.text,
                  'description': _description.text,
                  'timestamp': Timestamp.now(),
                  'name': 'username'
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
