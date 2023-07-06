import 'package:dart_flutter/res/size_config.dart';
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
    primary: Colors.indigoAccent,
    primaryContainer: Colors.indigoAccent.withOpacity(0.2),
    // secondary: Colors,
  )
);