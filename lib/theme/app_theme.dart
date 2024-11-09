import 'package:flutter/material.dart';

class AppTheme {
  static const Color pinkColor = Color(0xFFFFD6D6); // Pink
  static const Color blackColor = Color(0xFF333333); // Abu-abu
  static const Color whiteColor = Color(0xFFEFEFEF); // putih

  static final ThemeData themeData = ThemeData(
    primaryColor: whiteColor,
    scaffoldBackgroundColor: pinkColor,
    colorScheme: const ColorScheme.light(
      primary: blackColor,
      secondary: pinkColor,
      surface: blackColor,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: blackColor),
      bodyMedium: TextStyle(color: whiteColor),
    ),
  );
}
