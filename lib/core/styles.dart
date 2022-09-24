import 'dart:math';
import 'package:flutter/material.dart';

import './utils.dart';



int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}


class NordTheme {
  NordTheme._();

  static final MaterialColor primary = generateMaterialColor(const Color(0xFF79B8CA));
  static final MaterialColor frost1 = generateMaterialColor(const Color(0xFF8FBCBB));
  static final MaterialColor frost2 = generateMaterialColor(const Color(0xFF88C0D0));
  static final MaterialColor frost3 = generateMaterialColor(const Color(0xFF81A1C1));
  static final MaterialColor frost4 = generateMaterialColor(const Color(0xFF5E81AC));

  static final MaterialColor red = generateMaterialColor(const Color(0xFFBF616A));
  static final MaterialColor orange = generateMaterialColor(const Color(0xFFD08770));
  static final MaterialColor yellow = generateMaterialColor(const Color(0xFFEBCB8B));
  static final MaterialColor green = generateMaterialColor(const Color(0xFFA3BE8C));
  static final MaterialColor purple = generateMaterialColor(const Color(0xFFB48EAD));

  static final MaterialColor polar1 = generateMaterialColor(const Color(0xFF2E3440));
  static final MaterialColor polar2 = generateMaterialColor(const Color(0xFF3B4252));
  static final MaterialColor polar3 = generateMaterialColor(const Color(0xFF434C5E));
  static final MaterialColor polar4 = generateMaterialColor(const Color(0xFF4C566A));

  static final MaterialColor snow1 = generateMaterialColor(const Color(0xFFD8DEE9));
  static final MaterialColor snow2 = generateMaterialColor(const Color(0xFFE5E9F0));
  static final MaterialColor snow3 = generateMaterialColor(const Color(0xFFECEFF4));

  static Color shadeTint(Color color, double amount) => shadeOrTint(color, amount);
}
