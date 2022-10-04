import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

import '../providers/calculator_provider.dart';
import '../app/styles.dart';



class Display extends StatelessWidget {
  final double size;
  final int lines;
  final String value;

  const Display(this.value, this.size, [this.lines = 2, Key? key])
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
        // maxHeight: 120,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: NordTheme.snow1,
        borderRadius: BorderRadius.circular(5),
      ),
      child: AutoSizeText(
        value,
        maxLines: 3,
        style: TextStyle(
          fontSize: size,
          fontFamily: 'Nineteen97',
          color: Colors.blueGrey,
        ),
        textAlign: TextAlign.right,
        minFontSize: 16,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class CalcButton extends StatefulWidget {
  // final Color color;
  final String value;

  CalcButton(this.value, {Key? key}) : super(key: key);

  @override
  State<CalcButton> createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  var dot = true;

  void _copy(BuildContext context, String data, [bool inform=true]) async {
    data = data.replaceAll(',', '');
    await Clipboard.setData(ClipboardData(text: data));
    if(inform) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved'))
      );
    }
  }

  void _paste(CalculatorProvider calc) async {
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
      calc.append(finalStr);
    }
  }

  void _clearClipboard(BuildContext context) {
    _copy(context, '', false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Memory cleared'))
    );
  }

  // void _negpos(CalculatorProvider calc) {
  //   var chars = calc.equation.characters;
  //   List<String> valid = ['1', '2', '3', '4', '5', '6', '7', '8', '9',
  //                         '0', '.', ','];
  //   for(var i = 0; i < chars.length; i++) {
  //     if(i == 0 && calc.equation[i] == '-') continue;
  //     // if(calc.equation[i] == ',') continue;
  //     if(!valid.contains(calc.equation[i])) return;
  //   }
  //   calc.append('x-1');
  //   calc.compute();
  // }

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context, listen: false);

    if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(widget
        .value)) {
      return GestureDetector(
          onTap: () => calc.append(widget.value),
          child: CalcContent(
              color: Colors.white, text: Colors.black, value: widget.value));
    } else if (['+', '-', 'x', '÷'].contains(widget.value)) {
        return GestureDetector(
            onTap: () => calc.equation == '' && widget.value != '-'
                ? null : calc.append(widget.value),
            child: CalcContent(color: NordTheme.frost2.shade400, value: widget.value)
        );
    }

    switch(widget.value) {
      case '.':
        return GestureDetector(
            onTap: () => calc.append(widget.value),
            child: CalcContent(
                color: tintColor(Colors.grey, 0.3),
                value: widget.value
            )
        );

      case '00':
        return GestureDetector(
            onTap: () => calc.equation == '' ? null : calc.append(widget.value),
            child: CalcContent(
                color: tintColor(Colors.grey, 0.3),
                value: widget.value
            )
        );

      case '()':
        return Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () => calc.append('('),
                    child: CalcContent(
                      color: tintColor(Colors.grey, 0.3),
                      value: '(',
                      fontSize: 20,
                      radius: 'left',
                    )
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: GestureDetector(
                    onTap: () => calc.append(')'),
                    child: CalcContent(
                      color: tintColor(Colors.grey, 0.3),
                      value: ')',
                      fontSize: 20,
                      radius: 'right',
                    )
                ),
              ),
            ]
        );

      case 'M':
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _copy(context, calc.equation),
                child: CalcContent(
                  color: tintColor(Colors.grey, 0.3),
                  value: 'M+',
                  fontSize: 20,
                  radius: 'top',
                )
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: GestureDetector(
                onTap: () => _paste(calc),
                child: CalcContent(
                  color: tintColor(Colors.grey, 0.3),
                  value: 'MR',
                  fontSize: 20,
                  radius: 'bottom',
                )
              ),
            ),
          ],
        );

      // case '+/-':
      //   return GestureDetector(
      //       onTap: () => _negpos(calc),
      //       child: CalcContent(
      //           color: tintColor(Colors.grey, 0.3),
      //           value: widget.value)
      //   );

      case 'C':
        return GestureDetector(
          onTap: () => calc.clear(),
          child: CalcContent(
            color: tintColor(Colors.grey, 0.3),
            value: widget.value
          )
        );

      case '=':
        return GestureDetector(
          onTap: () => calc.equation == '' ? null : calc.compute(),
          child: CalcContent(
            color: Colors.orange, value: widget.value)
          );

      case 'del':
        return GestureDetector(
            onTap: () => calc.pop(),
            child: CalcContent(
                color: tintColor(Colors.grey, 0.3),
                value: const Icon(Icons.backspace, color: Colors.white,)
            )
        );

      default:
        return Container(width: 0);
    }
    // return CalcContent(color: Colors.grey, value: widget.value);
  }
}

class CalcContent extends StatelessWidget {
  final dynamic value;
  final Color color;
  final Color text;
  final bool useGradient;
  final double fontSize;
  final String radius;

  const CalcContent({
    required this.color,
    required this.value,
    this.text = Colors.white,
    this.useGradient = false,
    this.fontSize = 30,
    this.radius = 'all',
    Key? key,
  }) : super(key: key);

  Color darken(double amount, Color color) {
    var hsl = HSLColor.fromColor(color);
    var darkerColor = hsl.withLightness((hsl.lightness - amount).clamp(0, 1));
    return darkerColor.toColor();
  }

  BorderRadius _boxRadius(String radius) {
    if(radius == 'top') {
      return const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      );
      // return BorderRadius.circular(10);
    }
    else if(radius == 'bottom') {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    }
    else if(radius == 'left') {
      return const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
    }
    else if(radius == 'right') {
      return const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    }
    return BorderRadius.circular(10);
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
        borderRadius: _boxRadius(radius),
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
        // padding: radius == 'all'
        //   ? const EdgeInsets.all(10)
        //   : const EdgeInsets.symmetric(vertical: 7),
        child: Center(
          child: value is String
            ? FittedBox(
              child: Text(value, style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold, color: text
                  )),
            )
            : value,
        ),
      ),
    );
  }
}
