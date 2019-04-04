import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/transaction.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/wallet.dart';

abstract class HomePageViewModel extends State<HomePage> {
  String message = 'This wallet is Empty, make some transactions';
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();
  var snackKey = GlobalKey<ScaffoldState>();

  HomePageViewModel() {
    refresh(doPull: false);
  }

  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }
  Future<void> onRefresh() async {
    return await refresh(doPull: false);
  }
  Future<void> refresh({bool doPull=true}) async {
    try {
      if(doPull)
        await Dialogs.waitingDialog(context, Wallet.instance().pull, snackKey);
      try {
        await Wallet.instance().update();
        if(Wallet.instance().transactions.length==0) {
          message = 'This wallet is Empty, make some transactions';
        }
      } catch (e) {
        message = 'you need to pull your wallet';
      }
      setState((){});
    } catch(ex) {
      await Dialogs.messageDialog(context, 'error', ex.toString(), snackKey, false);
    }
  }

  Future<void> restart() async {
    DialogResult res = await Dialogs.messageDialog(context, 'Sure?',
    'the old wallet will be lost forever', snackKey, true);
    if(res==DialogResult.OK) {
      await Dialogs.waitingDialog(context, Wallet.instance().restart, snackKey,
      returnsJobId: false);
      await Wallet.instance().restart();
      String keygap = await Wallet.instance().getKeyGap();
      DialogResult res = await Dialogs.messageDialog(context, "Confirm", "You keygap is: $keygap please save it in a safe place\n"
        + "once you press okay it will be deleted from WTS server", snackKey, true);
      if(res==DialogResult.OK) {
        await Wallet.instance().confirm();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', '0');
      }
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', '0');
    await prefs.setString('keygap', '0');
    Navigator.of(context).pushReplacementNamed('/login');
  }
}