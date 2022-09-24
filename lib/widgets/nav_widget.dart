import 'package:flutter/material.dart';

import '../screens/calculator_screen.dart';
import '../screens/trading_screen.dart';
import '../screens/settings_screen.dart';
import '../core/styles.dart';


class MenuWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;

  MenuWidget(this._scaffoldKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 40,
        height: 40,
        decoration:BoxDecoration(
          color: NordTheme.primary,
          borderRadius: BorderRadius.circular(5)
        ),
        child: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white,
          ),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
    );
  }
}


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            Container(
                height: 100, color: NordTheme.primary,
                child: DrawerHeader(child: const Text('aaa'),)
            ),
            ListTile(
                title: const Text('Calculator', style: TextStyle(
                  color: Colors.black,
                )),
                leading: Icon(Icons.calculate, color: NordTheme.primary,),
                onTap: () => Navigator.of(context).pushReplacementNamed(CalculatorScreen.route)
            ),
            ListTile(
                title: const Text('Crypto', style: TextStyle(
                  color: Colors.black,
                )),
                leading: Icon(Icons.line_axis, color: NordTheme.primary,),
                onTap: () => Navigator.of(context).pushReplacementNamed(CryptoScreen.route)
            ),
            ListTile(
                title: const Text('Settings', style: TextStyle(
                  color: Colors.black,
                )),
                leading: Icon(Icons.settings, color: NordTheme.primary,),
                onTap: () => Navigator.of(context).popAndPushNamed(SettingsScreen.route)
            ),
            ListTile(
                title: const Text('About', style: TextStyle(
                  color: Colors.black,
                )),
                leading: Icon(Icons.info_outline, color: NordTheme.primary,),
                onTap: () {}
            ),
          ],
        )
    );
  }
}

