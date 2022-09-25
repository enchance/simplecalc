import 'package:flutter/material.dart';

import './screens/calculator_screen.dart';
import './screens/settings_screen.dart';



Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
  return {
    '/': (context) => CalculatorScreen(),
    SettingsScreen.route: (context) => SettingsScreen(),
  };
}