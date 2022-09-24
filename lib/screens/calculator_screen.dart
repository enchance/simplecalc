import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/Calculator.dart';
import '../widgets/calculator_widgets.dart';



class CalculatorScreen extends StatefulWidget {
  dynamic constraints;

  CalculatorScreen(this.constraints, {Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final List<String> _buttons = [
    'C', '(', ')', '/',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    'none', '0', '.', '=',
  ];

  void _copy(BuildContext context, String data) async {
    data = data.replaceAll(',', '');
    await Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!'))
    );
  }

  void _paste(CalculatorProvider calc) async {
    ClipboardData? cbdata = await Clipboard.getData('text/plain');
    if(cbdata != null) {
      String chars = cbdata.text as String;

      var finalStr = '';
      for(int i = 0; i < chars.length; i++) {
        if([
          '/',
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

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          width: (widget.constraints as BoxConstraints).maxWidth > 500
            ? 500
            : double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 100,
                  maxHeight: 163,
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                // margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  // border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(child: Display(calc.equation, 25)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => _paste(calc),
                          icon: const Icon(
                            Icons.paste_sharp,
                            color: Colors.black45,
                          )
                      ),
                      IconButton(
                          onPressed: () => _copy(context, calc.equation),
                          icon: const Icon(
                            Icons.copy,
                            color: Colors.black45,
                          )
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () => calc.pop(),
                    icon: const Icon(
                      Icons.backspace,
                      color: Colors.black54,
                    ),
                    label: const Text('Delete', style: TextStyle(
                        color: Colors.black54)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black54, width: 1)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: _buttons.length,
                  itemBuilder: (_, idx) => CalcButton(value: _buttons[idx]),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Display extends StatelessWidget {
  final double size;
  final int lines;
  final String value;

  const Display(this.value, this.size, [this.lines = 2, Key? key]) : super(key:
  key);

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      // maxLines: lines,
      style: TextStyle(
        fontSize: size,
        fontFamily: 'Nineteen97',
        color: Colors.blueGrey,
      ),
      textAlign: TextAlign.right,
    );
  }
}