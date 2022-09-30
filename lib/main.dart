import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:simplecalc/screens/crypto_screen.dart';
import 'package:simplecalc/screens/settings_screen.dart';

import './screens/calculator_screen.dart';
import './providers/calculator_provider.dart';
import './routes.dart';
import './core/styles.dart';


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

class _MyAppState extends State<MyApp> {
  var _currentIdx = 0;

  // void _navHandler(int idx) {
  //   setState(() => _currentIdx = idx);
  // }

  void pageHandler(int idx) => print(idx);

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculatorProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: NordTheme.primary,
          toggleableActiveColor: NordTheme.primary,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: NordTheme.snow3,
                elevation: 0,
                bottom: const TabBar(
                  labelColor: NordTheme.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: NordTheme.primary,
                  tabs: [
                    Tab(icon: Icon(Icons.calculate)),
                    Tab(icon: Icon(Icons.currency_bitcoin)),
                    Tab(icon: Icon(Icons.settings)),
                  ]
                ),
              ),
            ),
            body: TabBarView(
              children: [
                CalculatorScreen(),
                CryptoScreen(),
                SettingsScreen(),
              ],
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
