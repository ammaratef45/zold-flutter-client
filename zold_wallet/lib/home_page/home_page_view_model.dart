import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/wallet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// viewmodel of home page.
abstract class HomePageViewModel extends State<HomePage> {
  
  /// constructor
  HomePageViewModel() {
    refresh(doPull: false);
  }

  /// message to be shown instead of transactions.
  String message = 'This wallet is Empty, make some transactions';
  /// global key for showing snackbar from dialogs.
  GlobalKey<ScaffoldState> snackKey = GlobalKey<ScaffoldState>();
  /// indicate if id can be copied.
  bool canCopy = true;

  @override
  void dispose() {
    super.dispose();
    Wallet.instance().dispose();
  }
  /// refresh callback
  Future<void> onRefresh() async =>
    refresh(doPull: false);

  /// refresh the page.
  Future<void> refresh({bool doPull=true}) async {
    try {
      if(doPull) {
        await Dialogs.waitingDialog(
          context,
          Wallet.instance().pull,
          snackKey
        );
      }
      try {
        await Wallet.instance().update();
        if(Wallet.instance().transactions.isEmpty) {
          message = 'This wallet is Empty, make some transactions';
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        message = 'you need to pull your wallet';
      }
      setState((){});
    // ignore: avoid_catches_without_on_clauses
    } catch(ex) {
      await Dialogs.messageDialog(context, 'error', ex.toString(), snackKey);
    }
  }

  /// copy the id
  void copyid() {
    if(canCopy) {
      canCopy = false;
      Clipboard.setData(ClipboardData(text:  Wallet.instance().id));
      snackKey.currentState.showSnackBar(SnackBar
        (content: const Text('ID copied')));
      Future<void>.delayed(Duration(seconds:2)).then((_){
        canCopy = true;
      });
    }
  }

  /// restart the wallet.
  Future<void> restart() async {
    final DialogResult res = await Dialogs.messageDialog(context, 'Sure?',
    'the old wallet will be lost forever', snackKey, prompt: true);
    if(res==DialogResult.OK) {
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
        prompt: true
      );
      if(res==DialogResult.OK) {
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