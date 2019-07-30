import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/settings_page/settings_page.dart';
import 'package:zold_wallet/wallet.dart';
import 'package:share/share.dart';

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

  Future<String> _localPath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/${Wallet.instance().head.id}.txt';
  }

  Future<File> _localFile(String filePath) async => File(filePath);

  Future<File> _writeFile(String text, String filePath) async {
    final File file = await _localFile(filePath);
    return file.writeAsString('$text\r\n', mode: FileMode.write);
  }

  /// save the wallet's file locally
  Future<void> download() async {
    final String path = await _localPath();
    final String fileData = await Dialogs.waitingDialog(
        context, Wallet.instance().download, snackKey,
        returnsJobId: false);
    await _writeFile(fileData, path);
    final DialogResult dRes = await Dialogs.messageDialog(
        context, 'Done', 'Wallet downloaded\nPath:$path', snackKey,
        prompt: true, promptText: 'Share');
    if (dRes == DialogResult.ok) {
      await Share.share(fileData);
    }
  }
}
