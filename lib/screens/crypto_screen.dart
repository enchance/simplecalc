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
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (_, constraints) => Container(
              width: maxWidth > 500 ? 500 : double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  MenuWidget(_scaffoldKey),
                  SizedBox(height: 10),
                  const Text('Crypto')
                ],
              )
            ),
          ),
        )
      )
    );
  }
}
