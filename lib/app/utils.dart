import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';


String humanize(String eqn) {
  final f = NumberFormat.decimalPattern('en_US');

  Parser p = Parser();
  Expression exp = p.parse(eqn);
  double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
  return f.format(eval);
}

/*
* Values -1 - 1: Positive makes it darker, negative makes it lighter.
* */
Color shadeOrTint(Color color, double amount) {
  var hsl = HSLColor.fromColor(color);
  var alteredColor = hsl.withLightness((hsl.lightness - amount).clamp(0, 1));
  return alteredColor.toColor();
}