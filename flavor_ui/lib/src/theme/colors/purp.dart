import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Purp {
  static MaterialColor purp =
      const MaterialColor(_purpPrimaryValue, <int, Color>{
    50: Color(0xFFEDEDEE),
    100: Color(0xFFD3D2D6),
    200: Color(0xFFB6B4BA),
    300: Color(0xFF99959E),
    400: Color(0xFF837F8A),
    500: Color(_purpPrimaryValue),
    600: Color(0xFF65606D),
    700: Color(0xFF5A5562),
    800: Color(0xFF504B58),
    900: Color(0xFF3E3A45),
  });
  static const int _purpPrimaryValue = 0xFF6D6875;

  static const MaterialColor purpAccent =
      MaterialColor(_purpAccentValue, <int, Color>{
    100: Color(0xFFC2A1FB),
    200: Color(_purpAccentValue),
    400: Color(0xFF8037FF),
    700: Color(0xFF701EFF),
  });
  static const int _purpAccentValue = 0xFFA271F9;
}
