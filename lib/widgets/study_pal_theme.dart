import 'package:flutter/material.dart';

class StudyPalTheme {
  static const bool useMaterial3 = true;
  static const seedColor = Color(0xff0088FF);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,

      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      
    );
  }
}
