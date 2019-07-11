import 'package:flutter/material.dart';
import 'package:zold_wallet/settings_page/settings_page.dart';

/// Viewmodel of settings page
abstract class SettingsPageViewModel extends State<SettingsPage> {
  /// key for scaffold
  GlobalKey<ScaffoldState> snackKey = GlobalKey<ScaffoldState>();
}
