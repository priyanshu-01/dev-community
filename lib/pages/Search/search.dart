import 'package:flutter/material.dart';
import '../../main.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(hintText: 'Search'),
          ),
        )),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(userData[index]['name']),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
