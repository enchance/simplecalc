import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:simplecalc/screens/settings_screen.dart';

import '../providers/calculator_provider.dart';
import '../widgets/calculator_widgets.dart';



class CalculatorScreen extends StatefulWidget {
  // dynamic constraints;

  CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  final List<String> _buttons = [
    'C', '(', ')', 'del',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-',
    'none', '0', '.', '+',
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
    GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
    final calc = Provider.of<CalculatorProvider>(context);
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffolKey,
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   // toolbarHeight: 30,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   titleSpacing: -50,
      //   iconTheme: IconThemeData(
      //     color: Colors.grey[700],
      //   ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       Container(
      //         height: 100,
      //         color: Colors.grey[300],
      //         child: DrawerHeader(child: Text('aaa'),)
      //       ),
      //       ListTile(
      //           title: Text('Calculator'),
      //           leading: Icon(Icons.calculate),
      //           onTap: () {}
      //       ),
      //       ListTile(
      //           title: Text('Settings'),
      //           leading: Icon(Icons.settings),
      //           onTap: () {}
      //       ),
      //       ListTile(
      //           title: Text('About'),
      //           leading: Icon(Icons.info_outline),
      //           onTap: () {}
      //       ),
      //     ],
      //   )
      // ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (_, constraints) => Center(
            child: Container(
              width: maxWidth > 500 ? 500 : double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 22),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.grey,),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SettingsScreen.route);
                      },
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 163,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  const CalcButton('='),
                  const SizedBox(height: 15),
                ],
              ),
            ),
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