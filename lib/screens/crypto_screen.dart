import 'package:flutter/material.dart';

import '../widgets/nav_widget.dart';



class CryptoScreen extends StatefulWidget {
  static const route = '/crypto';
  const CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        body: Column(
          children: [
            SizedBox(height: 22),
            MenuWidget(_scaffoldKey),
            const Text('Crypto'),
          ],
        )
      )
    );
  }
}
