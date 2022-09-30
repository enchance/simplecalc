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
  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var _currentIdx = 0;
  final List<String> _buttons = [
    'C', 'exp', 'del', '/',
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
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: NordTheme.snow3,
      // key: _scaffoldKey,
      // backgroundColor: NordTheme.snow3,
      // appBar: AppBar(
      //   // toolbarHeight: 30,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   titleSpacing: -50,
      //   iconTheme: IconThemeData(
      //     color: Colors.grey[700],
      //   ),
      // ),
      // drawer: DrawerWidget(),

      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (_, constraints) => Container(
            width: maxWidth > 500 ? 500 : double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // MenuWidget(_scaffoldKey),
                  // SizedBox(height: 10),
                  Display(calc.equation, 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.paste, color: Colors.black38),
                        label: const Text('Paste'),
                        onPressed: () => _paste(calc),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.grey[600],
                          elevation: 0,
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.copy, color: Colors.black38),
                        label: const Text('Copy'),
                        onPressed: () => _copy(context, calc.equation),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.grey[600],
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  GridView(
                    padding: EdgeInsets.all(0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
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
      ),
    );
  }
}