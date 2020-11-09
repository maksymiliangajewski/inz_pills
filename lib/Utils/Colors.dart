import 'dart:ui';
import 'package:flutter/material.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

InputDecoration textInputDecoration(String title) {
  return InputDecoration(
      hintText: title,
      fillColor: Colors.white,
      filled: true,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2)));
}

class AppColors {
  static const Color imperialRed = Color.fromARGB(255, 230, 57, 70);
  static const Color honeydew = Color.fromARGB(255, 241, 250, 238);
  static const Color powderBlue = Color.fromARGB(255, 168, 218, 220);
  static const Color caladonBlue = Color.fromARGB(255, 69, 123, 157);
  static const Color prussianBlue = Color.fromARGB(255, 29, 53, 87);
}
