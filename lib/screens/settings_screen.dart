import 'package:flutter/material.dart';



class SettingsScreen extends StatelessWidget {
  static const route = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: const Text('Settings')
      )
    );
  }
}
