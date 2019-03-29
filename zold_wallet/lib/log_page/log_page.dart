import 'package:flutter/material.dart';
import 'package:zold_wallet/log_page/log_page_view.dart';
import 'package:zold_wallet/wts_log.dart';

class LogPage extends StatefulWidget {
  LogPage({this.log});

  final WtsLog log;

  @override
  LogPageView createState() => LogPageView(log);
}