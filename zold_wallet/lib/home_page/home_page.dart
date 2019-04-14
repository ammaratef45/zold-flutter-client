import 'package:flutter/material.dart';
import 'package:zold_wallet/home_page/home_page_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageView createState() => HomePageView();
}