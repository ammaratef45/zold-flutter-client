import 'package:flutter/material.dart';
import 'package:zold_wallet/wts_log.dart';
import './log_page.dart';


abstract class LogPageViewModel extends State<LogPage> {
  WtsLog log;
  var snackKey = GlobalKey<ScaffoldState>();

}