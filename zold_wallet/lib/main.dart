import 'package:flutter/material.dart';
import 'package:zold_wallet/create_page/create_page.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/log_page/log_page.dart';
import 'package:zold_wallet/login_page/login_page.dart';
import 'package:zold_wallet/pay_page/pay_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Widget myHome = LoginPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zold Wallet',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Monospace',
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(title: TextStyle(fontSize: 18))),
          textTheme: TextTheme(
            body1: TextStyle(fontSize: 16),
          )),
      home: myHome,
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/pay': (BuildContext context) => PayPage(),
        '/create': (BuildContext context) => CreatePage(),
      },
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/log') {
      return _buildRoute(settings, LogPage(log: settings.arguments));
    }
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
