import 'package:flutter/material.dart';

import '../config/utils.dart';


class CalculatorProvider with ChangeNotifier {
  String _equation = '';

  String get equation => _equation;

  void append(String char) {
    if(_equation.isNotEmpty) {
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
    if(_equation.isNotEmpty) {
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

    String cleanStr = _equation;
    cleanStr = cleanStr.replaceAll('x', '*').replaceAll(',', '');
    
    _equation = humanize(cleanStr);
    notifyListeners();

    return _equation;
  }
}