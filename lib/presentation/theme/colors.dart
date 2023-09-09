import 'package:flutter/material.dart';

class BrandColor {
  static const base = Color.fromARGB(255, 253, 246, 241);
  static const baseLight = Color.fromARGB(255, 255, 247, 241);
  static const baseBlue = Color(0xffaad3d1);
  static const baseRed = Color.fromARGB(255, 231, 161, 161);

  static const white = Colors.white;
  static const black = Color(0xff333333);
}

ThemeData brandThemeData = ThemeData(
  scaffoldBackgroundColor: BrandColor.base,
  colorScheme: const ColorScheme(
    primary: BrandColor.baseBlue,
    background: BrandColor.base,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: BrandColor.baseBlue,
    onError: Colors.transparent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    secondary: BrandColor.baseBlue,
    surface: Colors.white,
  ),
);
