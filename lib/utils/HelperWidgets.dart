import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget imageBox(String imagePath, Color? color) {
  return SizedBox(
    width: 24,
    height: 24,
    child: Image.asset(
      imagePath,
      color: color,
      fit: BoxFit.contain,
    ),
  );
}

Widget iconBox(IconData icon, Color? color) {
  return SizedBox(
      width: 24,
      height: 24,
      child: Icon(
        icon,
        color: color,
      ));
}
