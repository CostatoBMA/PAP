import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToGainButtonSimple extends StatelessWidget {
  String? icon;
  ToGainButtonSimple({this.icon});
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
        margin: EdgeInsets.all(5),
        child: Center(
            child: Image.asset(
          'imagens/$icon.png',
          height: 30,
          width: 30,
        )));
  }
}
