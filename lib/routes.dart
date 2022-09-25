import 'package:flutter/material.dart';
import 'package:simplecalc/screens/calculator_screen.dart';
import 'package:simplecalc/screens/settings_screen.dart';



RouteFactory getRoutes() {
  return (settings) {
    final Object? args = settings.arguments;
    Widget screen;

    switch(settings.name) {
      case SettingsScreen.route:
        screen = const SettingsScreen();
        break;
      default:
        screen = CalculatorScreen();
    }
    
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}