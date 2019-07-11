import 'package:flutter/material.dart';
import 'package:zold_wallet/log_page/log_page.dart';
import 'package:zold_wallet/wts_log.dart';

/// Viewmodel of log page
abstract class LogPageViewModel extends State<LogPage> {
  /// log object
  WtsLog log;

  /// key for scaffold
  GlobalKey<ScaffoldState> snackKey = GlobalKey<ScaffoldState>();
}
