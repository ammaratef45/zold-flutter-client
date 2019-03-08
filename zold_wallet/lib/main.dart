import 'package:flutter/material.dart';
import './home_page/home_page.dart';
import './login_page/login_page.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'dart:async';

void main() async {
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  await FlutterCrashlytics().initialize();

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
  });
}

class MyApp extends StatelessWidget {
  final Widget myHome = LoginPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zold Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: myHome,
      routes: {
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage(),
      },
    );
  }
}
