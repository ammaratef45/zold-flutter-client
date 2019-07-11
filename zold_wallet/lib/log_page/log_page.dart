import 'package:flutter/material.dart';
import 'package:zold_wallet/log_page/log_page_view.dart';
import 'package:zold_wallet/wts_log.dart';

/// The log page
class LogPage extends StatefulWidget {
  /// ctor
  const LogPage({this.log});

  /// Log object
  final WtsLog log;

  @override
  LogPageView createState() => LogPageView(log);
}
