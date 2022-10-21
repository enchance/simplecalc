import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';

import 'settings_provider.dart';
import '../collections/history.dart';
import '../utils.dart';
import './history_provider.dart';


class CalculatorProvider with ChangeNotifier {
  HistoryProvider? _history;
  String _equation = '';
  bool startAgain = false;

  set history(HistoryProvider provider) => _history = provider;

  String get equation => _equation;

  String talk() => 'Hello there';

  setStartAgain(bool val) => startAgain = val;

  append(String char) {
    List<String> operators = ['+', '-', 'x', '÷'];
    List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.`'];

    if(startAgain && numbers.contains(char)) _equation = '';

    if(_equation.isNotEmpty) {
      String lastChar = _equation[_equation.length - 1];
      if(operators.contains(lastChar) && operators.contains(char)) {
        _equation = _equation.substring(0, _equation.length - 1);
      }
    }
    _equation += char;
    notifyListeners();

    if(startAgain) setStartAgain(false);
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

  Future<String> compute([bool skipHistory=false]) async {
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
    if(!skipHistory) _history!.addHistory(history);

    notifyListeners();
    setStartAgain(true);
    return _equation;
  }

  paste() async {
    ClipboardData? cbdata = await Clipboard.getData('text/plain');
    if(cbdata != null) {
      String chars = cbdata.text as String;

      var finalStr = '';
      for(int i = 0; i < chars.length; i++) {
        if([
          '/', '(', ')',
          '7', '8', '9', 'x',
          '4', '5', '6', '-',
          '1', '2', '3', '+',
          '0', '.'
        ].contains(chars[i])) {
          finalStr += chars[i];
        }
      }
      append(finalStr);
    }
  }
}