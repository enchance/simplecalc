import 'package:SimpleCalc/app/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../app/providers/calculator_provider.dart';
import '../widgets/calculator_widgets.dart';
import './history_screen.dart';



class CalculatorScreen extends StatefulWidget {
  static const route = '/calculator';
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // var _currentIdx = 0;
  final List<String> _buttons = [
    // 'C', 'MR', 'M+', 'del',
    // '(', ')', 'M-', '÷',
    'C', 'paste', 'del', '÷',
    '7', '8', '9', 'x',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '+/-', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);

    return SingleChildScrollView(
        child: Center(
          child: Container(
            // width: maxWidth > 500 ? 500 : double.infinity,
            // alignment: Alignment.topCenter,
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _copy(context, calc.equation);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Copied'))
                      );
                    },
                      onLongPress: () {
                        Provider.of<CalculatorProvider>(context, listen: false).paste();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: const Text('Display pasted'))
                        );
                      },
                    child: Display(calc.equation, 34)
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 5),
                  GridView(
                    padding: const EdgeInsets.all(0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _buttons.map((item) => CalcButton(item)).toList(),
                  ),
                  // const SizedBox(height: 10),
                  // const CalcButton('='),
                  const SizedBox(height: 15),
                  TextButton.icon(
                      onPressed: () => Navigator.of(context).pushNamed(HistoryScreen.route),
                      icon: const Icon(Icons.history_outlined,
                        color: Colors.grey,
                      ),
                      label: const Text('View History',
                        style: TextStyle(
                            color: Colors.grey
                        )
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }

  void _copy(BuildContext context, String data, [bool inform=true]) async {
    data = data.replaceAll(',', '');
    await Clipboard.setData(ClipboardData(text: data));
    if(inform) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Copied'))
      );
    }
  }
}