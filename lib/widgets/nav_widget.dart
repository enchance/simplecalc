import 'package:flutter/material.dart';

import '../screens/calculator_screen.dart';
import '../screens/crypto_screen.dart';
import '../screens/settings_screen.dart';


class MenuWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey;

  MenuWidget(this._scaffoldKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(Icons.menu, color: Colors.grey,),
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
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
                height: 100,
                color: Colors.grey[300],
                child: DrawerHeader(child: Text('aaa'),)
            ),
            ListTile(
                title: Text('Calculator'),
                leading: Icon(Icons.calculate),
                onTap: () => Navigator.of(context).pushReplacementNamed(CalculatorScreen.route)
            ),
            ListTile(
                title: Text('Crypto'),
                leading: Icon(Icons.line_axis),
                onTap: () => Navigator.of(context).pushReplacementNamed(CryptoScreen.route)
            ),
            ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                onTap: () => Navigator.of(context).pushNamed(SettingsScreen.route)
            ),
            ListTile(
                title: Text('About'),
                leading: Icon(Icons.info_outline),
                onTap: () {}
            ),
          ],
        )
    );
  }
}

