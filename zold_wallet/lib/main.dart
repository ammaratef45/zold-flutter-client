import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zold_wallet/create_page/create_page.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/log_page/log_page.dart';
import 'package:zold_wallet/login_page/login_page.dart';
import 'package:zold_wallet/pay_page/pay_page.dart';
import 'package:trust_fall/trust_fall.dart';
import 'package:flutter/foundation.dart';

import 'stateless_views/untrusted_page.dart';

Future<void> main() async {
  if (await TrustFall.isTrustFall && kReleaseMode) {
    runApp(MaterialApp(
      home: UntrustedPage(),
    ));
  } else {
    runApp(MyApp());
  }
}

/// The application
class MyApp extends StatelessWidget {
  final Widget _myHome = LoginPage();
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Zold Wallet',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'RobotoMono',
            appBarTheme: AppBarTheme(
                textTheme: TextTheme(title: TextStyle(fontSize: 18))),
            buttonTheme: ButtonThemeData(
              buttonColor: Theme.of(context).accentColor,
              textTheme: ButtonTextTheme.primary,
            ),
            textTheme: TextTheme(body1: TextStyle(fontSize: 18))),
        home: _myHome,
        onGenerateRoute: _getRoute,
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/pay': (BuildContext context) => PayPage(),
          '/create': (BuildContext context) => CreatePage(),
        },
      );

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/log') {
      return _buildRoute(settings, LogPage(log: settings.arguments));
    }
    return null;
  }

  MaterialPageRoute<dynamic> _buildRoute(
          RouteSettings settings, Widget builder) =>
      MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext ctx) => builder,
      );
}
