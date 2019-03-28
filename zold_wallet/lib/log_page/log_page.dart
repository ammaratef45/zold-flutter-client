import 'package:flutter/material.dart';
import 'package:zold_wallet/wts_log.dart';
import './log_page_view.dart';

class LogPage extends StatefulWidget {
  LogPage({this.log});

  final WtsLog log;

  @override
  LogPageView createState() => LogPageView(log);
}