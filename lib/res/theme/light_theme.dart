import 'package:dart_flutter/res/config/size_config.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: SizeConfig.defaultSize * 2.0),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: const Color(0xff7C83FD),
    primaryContainer: const Color(0xff7C83FD).withOpacity(0.2),
    // secondary: Colors,
  )
);