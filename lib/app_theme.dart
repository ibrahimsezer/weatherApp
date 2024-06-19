import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color.fromARGB(255, 204, 212, 216);
  static const Color darkTheme = Color(0xFF000000);
  static const String fontName = 'WorkSans';
  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle lightBody1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.2,
    color: lightText,
  );
}
