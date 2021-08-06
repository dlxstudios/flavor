import 'dart:ui';

import 'package:flutter/material.dart';

const int blue = 0xFF38B0FF;
Color cBlue = Color(0xFF38B0FF);
const int green = 0xFF02D2A1;
Color cGreen = Color(0xFF02D2A1);
const int purple = 0xFFC750FF;
Color cPurple = Color(0xFFC750FF);
const int red = 0xFFFF5069;
Color cRed = Color(0xFFFF5069);
const int yellow = 0xFFE6FE4A;
Color cYellow = Color(0xFFE6FE4A);

abstract class FlavorPallet {
  static int get yellow => yellow;
  static int get red => red;
  static int get blue => blue;
  static int get green => green;
  static int get purple => purple;
}

final TextTheme defaultTextThemeDark = TextTheme(
  headline1: TextStyle(color: Colors.white),
  headline2: TextStyle(color: Colors.white),
  headline3: TextStyle(color: Colors.white),
  headline4: TextStyle(color: Colors.white),
  headline5: TextStyle(color: Colors.white),
  headline6: TextStyle(color: Colors.white),
  button: TextStyle(color: Colors.white),
  caption: TextStyle(color: Colors.white),
  subtitle1: TextStyle(color: Colors.white),
  subtitle2: TextStyle(color: Colors.white),
  bodyText1: TextStyle(color: Colors.white),
  bodyText2: TextStyle(color: Colors.white),
);

ThemeData flavorThemeMaterialDark = ThemeData.dark().copyWith(
  textTheme: defaultTextThemeDark,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(),
);

final TextTheme defaultTextThemeLight = TextTheme(
  headline1: TextStyle(color: Colors.black87),
  headline2: TextStyle(color: Colors.black87),
  headline3: TextStyle(color: Colors.black87),
  headline4: TextStyle(color: Colors.black87),
  headline5: TextStyle(color: Colors.black87),
  headline6: TextStyle(color: Colors.black87),
  button: TextStyle(color: Colors.black87),
  caption: TextStyle(color: Colors.black87),
  subtitle1: TextStyle(color: Colors.black87),
  subtitle2: TextStyle(color: Colors.black87),
  bodyText1: TextStyle(color: Colors.black87),
  bodyText2: TextStyle(color: Colors.black87),
);

ThemeData flavorThemeMaterialLight = ThemeData.light().copyWith(
  textTheme: defaultTextThemeLight,
  primaryColor: Colors.red,
  accentColor: Colors.red,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
);
