import 'package:flutter/material.dart';

class Palette {
  static const int _palette1PrimaryValue = 0xFF00293A;
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE0E5E7),
      100: Color(0xFFB3BFC4),
      200: Color(0xFF80949D),
      300: Color(0xFF4D6975),
      400: Color(0xFF264958),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF002434),
      700: Color(0xFF001F2C),
      800: Color(0xFF001925),
      900: Color(0xFF000F18),
    },
  );
}

class ThemeColors {
  static const primaryColor = Color(0xFF00293A);
  static const secondaryColor = Color(0xFF69DBC8);
  static const lightPrimary = Color(0xFF003C55);
  static const fullLightPrimary = Color(0xff007296);
  static const black1 = Color(0xFF2E3440);
  static const black2 = Color(0xFF0D0925);
  static const yellow = Color(0xFFECD925);
  static const errorRedColor = Color(0xFFEC2525);
  static const redColor = Color(0xFFDC3636);
  static const red1 = Color(0xFFDB6969);
  static const green1 = Color(0xFF4094AE);
  static const green2 = Color(0xFF009383);
  static const green3 = Color(0xFF008980);
  static const green4 = Color(0xFF8fcfc8);
  static const grey1 = Color(0xFF49545F);
  static const grey2 = Color(0xFFBBBFC3);
  static const grey3 = Color(0xFFEFEFEF);
  static const grey4 = Color(0xFFFAFBFC);
  static const grey5 = Color(0xFFCFD6D5);
  static const grey6 = Color(0xFF5E6C84);
  static const grey7 = Color(0xFFF6F7F8);
  static const grey8 = Color(0xFF979797);
  static const grey9 = Color(0xFFFBFBFB);
  static const white = Color(0xffF6F7F8);
  static const purple = Color(0xFF7269DB);
  static const blue1 = Color(0xFFD9EAEF);
  static const brown = Color(0xFF3A515D);
}
