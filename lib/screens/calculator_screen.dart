import 'package:flutter/material.dart';
import 'dart:ui';


class CalculatorScreen extends StatefulWidget {

  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<String> _buttons = [
    'c', 'abs', 'del', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '00', '0', '.', '=',
  ];
  var display = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Text('Display here')
            ),
            Expanded(
              child: GridView.builder(
                itemCount: _buttons.length,
                itemBuilder: (_, idx) => CalcButton(value: _buttons[idx]),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CalcButton extends StatelessWidget {
  // final Color color;
  final String value;

  const CalcButton({
    // required this.color,
    required this.value,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'].contains(value)) {
      return GestureDetector(
        onTap: () {
          print(value);
        },
        child: CalcContent(color: Colors.white, text: Colors.red, value: value)
      );
    }
    else {
      switch(value) {
        case '+':
        case '-':
        case 'x':
        case '/':
          return CalcContent(
              color: Colors.blueGrey.shade400, value: value
          );
        case '=':
          return CalcContent(
              color: Colors.orange, value: value
          );
        default:
          return CalcContent(color: Colors.grey, value: value);
      };
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
    this.text=Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: FittedBox(
          child: value is String
            ? Text(value, style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: text
              ),)
            : value
        ),
      ),
    );
  }
}
