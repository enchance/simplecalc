import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './core/providers/settings.dart';
import './providers/calculator_provider.dart';
import './routes.dart';
import './core/theme.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => Settings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
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
    SizedBox(height: 20),
  ];
}
