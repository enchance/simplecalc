import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';



class CalculatorProvider extends ChangeNotifier {
  String _equation = '';

  String get equation => _equation;

  void append(String char) {
    if(_equation.length > 0) {
      String lastChar = _equation[_equation.length - 1];
      List<String> operators = ['+', '-', 'x', '/'];
      if(operators.contains(lastChar) && operators.contains(char)) {
        _equation = _equation.substring(0, _equation.length - 1);
      }
    }
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
    // final f = NumberFormat('#,##0.00', 'en_US');
    final f = NumberFormat.decimalPattern('en_US');

    String finalEquation = equation;
    finalEquation = finalEquation.replaceAll('x', '*').replaceAll(',', '');
    // finalEquation = finalEquation.replaceAll(',', '');

    Parser p = Parser();
    Expression exp = p.parse(finalEquation);
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    _equation = f.format(eval);
    notifyListeners();

    return _equation;
  }
}