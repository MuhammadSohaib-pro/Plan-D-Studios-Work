import 'package:flutter/material.dart';

class ThemeColors {
  static const mainColor = Color(0xff0C8A7B);
  static const bgColor = Color(0xffF9F9F9);
  static const black1 = Color(0xff1A1D1E);
  static const grey1 = Color(0xff828A89);
  static const grey2 = Color(0xff6A6A6A);
  static const grey3 = Color(0xffA4A4A4);
  static const grey4 = Color(0xffA7A6A5);
  static const grey5 = Color(0xffEFF2F1);
  static const red = Color(0xffEA3549);

}


class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE2F1EF),
      100: Color(0xFFB6DCD7),
      200: Color(0xFF86C5BD),
      300: Color(0xFF55ADA3),
      400: Color(0xFF309C8F),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF0A8273),
      700: Color(0xFF087768),
      800: Color(0xFF066D5E),
      900: Color(0xFF035A4B),
    },
  );

  static const int _palette1PrimaryValue = 0xFF0C8A7B;
}