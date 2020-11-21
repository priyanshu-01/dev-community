import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Image.network(
        "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        fit: BoxFit.cover,
      ),
    );
  }
}
