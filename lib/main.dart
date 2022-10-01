import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:simplecalc/core/providers/settings.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import './screens/calculator_screen.dart';
import './providers/calculator_provider.dart';
import './routes.dart';
import './core/styles.dart';
import './screens/trading_screen.dart';
import './screens/settings_screen.dart';
import './core/theme.dart';


void main() {

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // void _navHandler(int idx) {
  //   setState(() => _currentIdx = idx);
  // }

  void pageHandler(int idx) => print(idx);
  final List<Widget> _pages = const [
    CalculatorScreen(),
    CryptoScreen(),
    // SettingsScreen(),
  ];

  final controller = PageController(
    initialPage: 0,
  );

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

    // Prevent landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => Settings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.light(),
        home: KeyboardDismisser(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
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
                    // Tab(icon: Icon(Icons.settings, size: 30,)),
                  ]
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: _pages,
            )
          ),
        )
        // home: PageView(
        //   onPageChanged: pageHandler,
        //   controller: controller,
        //   children: _pages,
        // ),
        // home: Scaffold(
        //   bottomNavigationBar: BottomNavigationBar(
        //     selectedItemColor: NordTheme.primary,
        //     currentIndex: _currentIdx,
        //     onTap: _navHandler,
        //     showSelectedLabels: false,
        //     showUnselectedLabels: false,
        //     items: const [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.calculate),
        //         label: 'Calculator',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.currency_bitcoin),
        //         label: 'Crypto',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.settings),
        //         label: 'Settings',
        //       ),
        //     ],
        //   ),
        //   body: _pages.elementAt(_currentIdx),
        // )
        // routes: getRoutes(context),
      ),
    );
  }
}


List<Widget> buildHeadlineText(BuildContext context, String text,
    [double padding=0]) {
  return [
    Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Text(text,
        style: Theme.of(context).textTheme.headline1,
      ),
    ),
    SizedBox(height: 20),
  ];
}
