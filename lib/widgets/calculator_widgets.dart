import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../core/styles.dart';


class CalcButton extends StatefulWidget {
  // final Color color;
  final String value;

  CalcButton(this.value, {Key? key}) : super(key: key);

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  var dot = true;

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(widget.value)) {
      return GestureDetector(
          onTap: () {
            calc.append(widget.value);
            print(dot);
          },
          child: CalcContent(color: Colors.white, text: Colors.black, value: widget.value));
    } else if (['.', '(', ')'].contains(widget.value)) {
      return GestureDetector(
          onTap: () {
            // if(widget.value == '.' && !dot) return;
            // setState(() => dot = false);
            calc.append(widget.value);
          },
          child: CalcContent(
              color: NordTheme.shadeTint(Colors.grey, -0.1),
              text: Colors.white,
              value: widget.value)
      );
    } else if (['+', '-', 'x', '/'].contains(widget.value)) {
      return GestureDetector(
          onTap: () => calc.equation == '' ? null : calc.append(widget.value),
          child: CalcContent(
              // color: NordTheme.shadeTint(NordTheme.frost3, -0.05), value: value)
              color: NordTheme.frost2, value: widget.value)
      );
    } else if (['='].contains(widget.value)) {
      return GestureDetector(
          onTap: () => calc.equation == '' ? null : calc.compute(),
          child: CalcContent(
            // color: NordTheme.shadeTint(NordTheme.primary, 0.1), value: value)
          color: NordTheme.green, value: widget.value)
      );
    } else if(widget.value == 'del') {
        return GestureDetector(
          onTap: () {
            String char = calc.pop();
            if(char == '.') setState(() => dot = true);
            // TODO: dot won't come back
          },
          child: CalcContent(
            color: NordTheme.shadeTint(Colors.grey, -0.1),
            value: Icon(Icons.backspace, color: Colors.white,)
          )
        );
    } else if (widget.value == 'C') {
      return GestureDetector(
          onTap: () => calc.clear(),
          child: CalcContent(color: Colors.grey.shade600, value: widget.value));
    }
    else if(widget.value == 'none') {
      return const CalcContent(
          color: Colors.transparent,
          value: Icon(Icons.local_cafe_outlined, color: Colors.black38),
      );
    }
    return CalcContent(color: Colors.grey, value: widget.value);
  }
}

class CalcContent extends StatelessWidget {
  final dynamic value;
  final Color color;
  final Color text;
  final bool useGradient;

  const CalcContent({
    required this.color,
    required this.value,
    this.text = Colors.white,
    this.useGradient = false,
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
        gradient: useGradient
          ? LinearGradient(
              colors: [color, darken(0.1, color)],
              stops: [.5, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
        color: useGradient
          ? null
          : color,
        borderRadius: BorderRadius.circular(10),
        border: color == Colors.white
            ? Border.all(color: darken(0.03, color), width: 1)
            : Border.all(color: color, width: 2),
        boxShadow: color == Colors.white
            ? const [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.black26,
                  offset: Offset(1, 1),
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
