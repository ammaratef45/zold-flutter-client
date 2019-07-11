import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/settings_page/settings_page.dart';
import 'package:zold_wallet/wallet.dart';

/// Viewmodel of settings page
abstract class SettingsPageViewModel extends State<SettingsPage> {
  /// key for scaffold
  GlobalKey<ScaffoldState> snackKey = GlobalKey<ScaffoldState>();

  /// restart the wallet.
  Future<void> restart() async {
    final DialogResult res = await Dialogs.messageDialog(
        context, 'Sure?', 'the old wallet will be lost forever', snackKey,
        prompt: true);
    if (res == DialogResult.ok) {
      await Dialogs.waitingDialog(context, Wallet.instance().restart, snackKey,
          returnsJobId: false);
      await Wallet.instance().restart();
      final String keygap = await Wallet.instance().getKeyGap();
      final DialogResult res = await Dialogs.messageDialog(
          context,
          'Confirm',
          'You keygap is: $keygap please save it in a safe place\n'
              'once you press okay it will be deleted from WTS server',
          snackKey,
          prompt: true);
      if (res == DialogResult.ok) {
        await Wallet.instance().confirm();
      } else {
        final FlutterSecureStorage prefs = FlutterSecureStorage();
        await prefs.write(key: 'key', value: '0');
      }
    }
  }

  /// perform logout.
  Future<void> logout() async {
    final FlutterSecureStorage prefs = FlutterSecureStorage();
    await prefs.write(key: 'key', value: '0');
    await prefs.write(key: 'keygap', value: '0');
    await Navigator.of(context).pushReplacementNamed('/login');
  }
}
