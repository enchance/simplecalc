import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import './screens/history.dart';
import './screens/index.dart';




Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
  return {
    '/': (context) => IndexScreen(),
    HistoryScreen.route: (_) => HistoryScreen()
    // CalculatorScreen.route: (context) => CalculatorScreen(),
    // SettingsScreen.route: (context) => SettingsScreen(),
    // CryptoScreen.route: (context) => CryptoScreen(),

  };
}