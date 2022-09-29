import 'package:flutter/material.dart';

import './utils.dart';


class NordTheme {
  NordTheme._();

  static const Color primary = Color(0xFF79B8CA);
  static const Color frost1 = Color(0xFF8FBCBB);
  static const Color frost2 = Color(0xFF88C0D0);
  static const Color frost3 = Color(0xFF81A1C1);
  static const Color frost4 = Color(0xFF5E81AC);
  static int frost2_int = 0xFF88C0D0;
  static const MaterialColor frost2_swatch = MaterialColor(
      0xFF88C0D0, <int, Color>{
      500: Color(0xFF88C0D0),
    }
  );

  static const Color red = Color(0xFFBF616A);
  static const Color orange = Color(0xFFD08770);
  static const Color yellow = Color(0xFFEBCB8B);
  static const Color green = Color(0xFFA3BE8C);
  static const Color purple = Color(0xFFB48EAD);

  static const Color polar1 = Color(0xFF2E3440);
  static const Color polar2 = Color(0xFF3B4252);
  static const Color polar3 = Color(0xFF434C5E);
  static const Color polar4 = Color(0xFF4C566A);

  static const Color snow1 = Color(0xFFD8DEE9);
  static const Color snow2 = Color(0xFFE5E9F0);
  static const Color snow3 = Color(0xFFECEFF4);

  static Color shadeTint(Color color, double amount) => shadeOrTint(color, amount);
}
