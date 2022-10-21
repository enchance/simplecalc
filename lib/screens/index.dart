import 'package:SimpleCalc/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';

import '../app/styles.dart';
import './calculator_screen.dart';
import './trading_screen.dart';



class IndexScreen extends StatefulWidget {

  IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _pages = const [
    CalculatorScreen(),
    CryptoScreen(),
    InfoScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {
      if(_tabController.index != 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return KeyboardDismisser(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: NordTheme.primary,
              bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: NordTheme.primary.shade200,
                  indicatorColor: NordTheme.primary,
                  tabs: const [
                    Tab(icon: Icon(Icons.calculate, size: 30,)),
                    Tab(icon: Icon(Icons.area_chart, size: 30,)),
                    Tab(icon: Icon(Icons.info, size: 30,)),
                  ]
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: _pages,
          )
      ),
    );
  }
}
