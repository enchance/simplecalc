import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorProvider extends ChangeNotifier {
  String _equation = '';

  String get equation => _equation;

  void append(String char) {
    _equation += char;
    notifyListeners();
  }

  void pop() {
    if(_equation.length > 0) {
      _equation = _equation.substring(0, _equation.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _equation = '';
    notifyListeners();
  }

  String compute() {
    String finalEquation = equation;
    finalEquation = finalEquation.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalEquation);
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());

    _equation = eval % 1 == 0 ? eval.toInt().toString() : eval.toString();
    notifyListeners();

    return _equation;
  }
}