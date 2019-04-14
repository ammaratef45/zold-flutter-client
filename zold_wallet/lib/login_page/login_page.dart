import 'package:flutter/material.dart';
import 'package:zold_wallet/login_page/login_page_view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageView createState() => LoginPageView();
}