import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';


String humanize(String eqn) {
  final f = NumberFormat.decimalPattern('en_US');

  Parser p = Parser();
  Expression exp = p.parse(eqn);
  double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
  return f.format(eval);
}