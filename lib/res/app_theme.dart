import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightThemeData = themeData();

  static ThemeData themeData() {
    final base = ThemeData.light();
    return base.copyWith(
      useMaterial3: true,
    );
  }
}
