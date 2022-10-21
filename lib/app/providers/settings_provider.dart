import 'package:SimpleCalc/app/providers/calculator_provider.dart';
import 'package:flutter/material.dart';


class BaseSettings {
  var appname = 'Simple Calculator';
}


class SettingsProvider extends BaseSettings with ChangeNotifier {
  CalculatorProvider? calc;

  SettingsProvider([this.calc]);

  String foo() => calc!.talk();
}