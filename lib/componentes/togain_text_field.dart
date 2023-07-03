import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToGainTextField extends StatelessWidget {
  String? label;
  TextEditingController? controller;
  Function(String)? onChanged;
  Function(String)? onSubmited;
  String? errorText;
  Color color;
  Color? textColor;
  bool? obscure;
  double? size;
  double? marginLeft;
  double? marginRight;

  ToGainTextField(
      {this.label,
      this.controller,
      this.obscure = false,
      this.color = Colors.white,
      this.textColor,
      this.size,
      this.marginLeft,
      this.errorText,
      this.marginRight,
      this.onChanged,
      this.onSubmited});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        margin: EdgeInsets.only(
            left: marginLeft ?? 30,
            right: marginRight ?? 30,
            top: 5,
            bottom: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            const Radius.circular(80.0),
          ),
        ),
        width: size ?? MediaQuery.of(context).size.width,
        child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscure!,
          onFieldSubmitted: onSubmited,
          style: TextStyle(
              color: textColor != null ? textColor : Color(0xff178283)),
          decoration: InputDecoration(
            errorText: errorText,
            hintText: label,
            hintStyle: TextStyle(
                color: textColor != null ? textColor : Color(0xff178283)),
          ),
        ));
  }
}
