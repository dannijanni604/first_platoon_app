import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget kAppButton({
  String? label,
  EdgeInsetsGeometry? padding,
  VoidCallback? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Material(
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black26)),
      child: Padding(
        padding: padding ?? EdgeInsets.all(10),
        child: Text(label ?? "Label"),
      ),
    ),
  );
}
