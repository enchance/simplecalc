import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Calculator.dart';


class CalcButton extends StatelessWidget {
  // final Color color;
  final String value;

  const CalcButton(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.append(value),
          child: CalcContent(color: Colors.white, text: Colors.black, value: value));
    } else if (['.', '(', ')', '^'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.append(value),
          child: CalcContent(
              color: Colors.grey, text: Colors.white, value: value));
    } else if (['+', '-', 'x', '/'].contains(value)) {
      return GestureDetector(
          onTap: () => calc.equation == '' ? null : calc.append(value),
          child: CalcContent(color: Colors.blueGrey.shade400, value: value));
    } else if(value == 'del') {
        return GestureDetector(
          onTap: () => calc.pop(),
          child: CalcContent(
            color: Colors.grey,
              value: Icon(Icons.backspace, color: Colors.white,)
          )
        );
    } else if (value == '=') {
      return GestureDetector(
          onTap: () => calc.equation == '' ? null : calc.compute(),
          child: CalcContent(color: Colors.orange, value: value));
    } else if (value == 'C') {
      return GestureDetector(
          onTap: () => calc.clear(),
          child: CalcContent(color: Colors.grey.shade800, value: value));
    }
    else if(value == 'none') {
      return const CalcContent(
          color: Colors.transparent,
          value: Icon(Icons.local_cafe_outlined, color: Colors.black38),
      );
    }
    else {
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

  Color darken(double amount, Color color) {
    var hsl = HSLColor.fromColor(color);
    var darkerColor = hsl.withLightness((hsl.lightness - amount).clamp(0, 1));
    return darkerColor.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, darken(0.2, color)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        border: color == Colors.white
            ? Border.all(color: darken(0.03, color), width: 1)
            : Border.all(color: color, width: 2),
        boxShadow: color == Colors.white
            ? const [
                BoxShadow(
                  blurRadius: 2, color: Colors.grey, offset: Offset(1, 1)
                )
              ]
            : []
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: value is String
            ? Text(value, style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold, color: text
                ))
            : value,
        ),
      ),
    );
  }
}
