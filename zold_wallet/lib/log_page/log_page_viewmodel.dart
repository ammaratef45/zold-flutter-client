import 'package:flutter/material.dart';
import 'package:zold_wallet/log_page/log_page.dart';
import 'package:zold_wallet/wts_log.dart';


abstract class LogPageViewModel extends State<LogPage> {
  WtsLog log;
  var snackKey = GlobalKey<ScaffoldState>();

}