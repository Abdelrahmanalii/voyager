import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [BoxShadow(color: Colors.blueAccent)]),
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red))),
    );
  }
}
