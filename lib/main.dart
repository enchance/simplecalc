import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './app/collections/history.dart';
import './app/theme.dart';
import './app/providers/settings_provider.dart';
import './app/providers/calculator_provider.dart';
import './app/providers/history_provider.dart';
import './routes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Isar
  final dir = await getApplicationSupportDirectory();
  await Isar.open(
    [HistorySchema],
    directory: dir.path,
  );

  runApp(const MyApp());
}

// Future initialization(BuildContext? context) async {
//   await Future.delayed(Duration(seconds: 3));
// }

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    // Prevent landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProxyProvider<HistoryProvider, CalculatorProvider>(
            create: (_) => CalculatorProvider(),
            update: (_, history, calc) => calc!..history = history
        ),

        // ChangeNotifierProxyProvider<CalculatorProvider, Settings>(
        //   create: (context) => Settings(),
        //   update: (context, calc, settings) => Settings(calc),
        // ),

        // Passing CalculatorProvider like this is ok as long as it NEVER
        // changes since the change would not be reflected. In fact, passing
        // values in the constructor will assume it will never change so
        // don't do it UNLESS it's really not meant to change.
        // ChangeNotifierProvider(create: (_) => SettingsProv(CalculatorProvider()))

        // ChangeNotifierProvider(create: (_) => Settings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BigButton Calculator',
        theme: AppTheme.light(),
        routes: getRoutes(context),
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
    const SizedBox(height: 20),
  ];
}
