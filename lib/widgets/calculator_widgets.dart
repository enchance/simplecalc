import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Calculator.dart';


class CalcButton extends StatelessWidget {
  // final Color color;
  final String value;

  const CalcButton(
      {
        // required this.color,
        required this.value,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.append(value),
          child:
          CalcContent(color: Colors.white, text: Colors.red, value: value));
    } else if (['.', '(', ')'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.append(value),
          child: CalcContent(
              color: Colors.grey, text: Colors.white, value: value));
    } else if (['+', '-', 'x', '/'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.append(value),
          child: CalcContent(color: Colors.blueGrey.shade400, value: value));
    } else if (value == '=') {
      return GestureDetector(
          onTap: () => calc.compute(),
          child: CalcContent(color: Colors.orange, value: value));
    } else if (value == 'C') {
      return GestureDetector(
          onTap: () => calc.clear(),
          child: CalcContent(color: Colors.grey.shade800, value: value));
    } else {
      return CalcContent(color: Colors.grey, value: value);
    }
  }
}

class CalcContent extends StatelessWidget {
  final dynamic value;
  final Color color;
  final Color text;

  const CalcContent({
    required this.color,
    required this.value,
    this.text = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: FittedBox(
            child: value is String
                ? Text(
              value,
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: text),
            )
                : value),
      ),
    );
  }
}
