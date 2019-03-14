import 'package:flutter/material.dart';
import './pay_page_view.dart';

class PayPage extends StatefulWidget {
  PayPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  PayPageView createState() => PayPageView();
}