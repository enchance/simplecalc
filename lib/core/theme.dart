import 'package:flutter/material.dart';
import './styles.dart';



class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primarySwatch: generateMaterialColor(NordTheme.primary),
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 15)
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(
                  fontSize: 20,
                )
            ),
          )
      ),
    );
  }
}


// ThemeData appTheme() {
// }