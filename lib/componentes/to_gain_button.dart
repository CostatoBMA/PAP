import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToGainButton extends StatelessWidget {
  String? label;

  ToGainButton({this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xff178283),
          borderRadius: BorderRadius.all(
            const Radius.circular(80.0),
          ),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          label!,
          style: TextStyle(color: Colors.white),
        )));
  }
}
