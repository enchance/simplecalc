import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:math_expressions/math_expressions.dart';

import '../app/collections/history.dart';
import '../app/utils.dart';


class CalculatorProvider with ChangeNotifier {
  String _equation = '';

  String get equation => _equation;

  void append(String char) {
    if(_equation.isNotEmpty) {
      String lastChar = _equation[_equation.length - 1];
      List<String> operators = ['+', '-', 'x', '÷'];
      if(operators.contains(lastChar) && operators.contains(char)) {
        _equation = _equation.substring(0, _equation.length - 1);
      }
    }
    _equation += char;
    notifyListeners();
  }

  String pop() {
    if(_equation.isNotEmpty) {
      String last = _equation[_equation.length - 1];
      _equation = _equation.substring(0, _equation.length - 1);
      notifyListeners();
      return last;
    }
    return '';
  }

  void clear() {
    _equation = '';
    notifyListeners();
  }

  Future<String> compute() async {
    final Isar isar = Isar.getInstance()!;
    final history = History()
      ..problem=_equation..createdAt=DateTime.now();

    String cleanStr = _equation;
    cleanStr = cleanStr.replaceAll('x', '*').replaceAll(',', '');
    cleanStr = cleanStr.replaceAll('÷', '/').replaceAll(',', '');

    // Solve
    Parser p = Parser();
    Expression exp = p.parse(cleanStr);
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    _equation = humanize(eval);

    // Save to db
    history.solution = _equation;
    await isar.writeTxn(() async {
      await isar.historys.put(history);
    });

    notifyListeners();
    return _equation;
  }
}