import 'package:flutter/material.dart';

class Const {
  static labelText({
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color,
    );
  }

  static String? validateCode(String value) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter code';
    } else {
      if (!regex.hasMatch(value)) {
        return 'code must contain 1 capital alphabet, numbers and 8 length';
      } else {
        return null;
      }
    }
  }
}
