import 'package:flutter/material.dart';

class AppConstants {
  static const primaryColorDark1 = Color(0xff060C18);
  static const primaryColorDark2 = Color(0xff161A34);

  static const String serverUrl = "https://klitchy.com/backend/api";
  static const String socketUrl = "http://13.41.208.159:3030";

  static const MaterialColor mcgpalette0 =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFE1E2E3),
    100: Color(0xFFB4B6BA),
    200: Color(0xFF83868C),
    300: Color(0xFF51555D),
    400: Color(0xFF2B303B),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF050A15),
    700: Color(0xFF040811),
    800: Color(0xFF03060E),
    900: Color(0xFF020308),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF060C18;

  static const MaterialColor mcgpalette0Accent =
      MaterialColor(_mcgpalette0AccentValue, <int, Color>{
    100: Color(0xFF4E4EFF),
    200: Color(_mcgpalette0AccentValue),
    400: Color(0xFF0000E7),
    700: Color(0xFF0000CE),
  });
  static const int _mcgpalette0AccentValue = 0xFF1B1BFF;
}
