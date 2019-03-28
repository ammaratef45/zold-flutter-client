import 'package:flutter/material.dart';
import 'package:zold_wallet/log_page/log_page.dart';
import './home_page/home_page.dart';
import './login_page/login_page.dart';
import './pay_page/pay_page.dart';
import './create_page/create_page.dart';

void main() => runApp(MyApp());

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
      onGenerateRoute: _getRoute,
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
        '/pay': (BuildContext context) => PayPage(),
        '/create': (BuildContext context) => CreatePage(),
      },
    );
  }

  Route<dynamic>  _getRoute(RouteSettings settings) {
    if (settings.name == '/log') {
        return _buildRoute(settings, LogPage(log: settings.arguments));
    }
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
        settings: settings,
        builder: (ctx) => builder,
    );
}
}
