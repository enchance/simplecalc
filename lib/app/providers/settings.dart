import 'package:SimpleCalc/providers/calculator_provider.dart';
import 'package:flutter/material.dart';


class BaseSettings {
  var appname = 'Simple Calculator';
}


class Settings extends BaseSettings with ChangeNotifier {
  CalculatorProvider? calc;

  Settings([this.calc]);

  String foo() => calc!.talk();
}