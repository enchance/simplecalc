import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/calculator_screen.dart';
import './providers/Calculator.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) => CalculatorScreen(constraints)
          ),
        )
      ),
    );
  }
}
