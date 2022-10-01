import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:simplecalc/screens/settings_screen.dart';

import '../providers/calculator_provider.dart';
import '../widgets/calculator_widgets.dart';
import '../widgets/nav_widget.dart';
import '../core/styles.dart';


class CalculatorScreen extends StatefulWidget {
  static const route = '/calculator';
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // var _currentIdx = 0;
  final List<String> _buttons = [
    'C', '(', ')', 'del', '÷',
    'MR', '7', '8', '9', 'x',
    'M+', '4', '5', '6', '-',
    'M-', '1', '2', '3', '+',
    '+/-', '00', '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<CalculatorProvider>(context);
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: NordTheme.snow3,
      body: SingleChildScrollView(
        child: Container(
          width: maxWidth > 500 ? 500 : double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            child: Column(
              children: [
                SizedBox(height: 20),
                Display(calc.equation, 22),
                SizedBox(height: 20),
                const SizedBox(height: 5),
                GridView(
                  padding: EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _buttons.map((item) => CalcButton(item)).toList(),
                ),
                // const SizedBox(height: 10),
                // const CalcButton('='),
                // const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}