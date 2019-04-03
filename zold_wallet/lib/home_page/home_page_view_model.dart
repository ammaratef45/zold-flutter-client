import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/transaction.dart';
import 'dart:math';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/wallet.dart';

abstract class HomePageViewModel extends State<HomePage> {
  Wallet wallet = Wallet.instance();
  String id = "";
  String balance = "";
  String balanceZent = "";
  String message = 'This wallet is Empty, make some transactions';
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();
  var snackKey = GlobalKey<ScaffoldState>();
  List<Transaction> transactions =List();

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
      await wallet.getId();
      if(doPull)
        await Dialogs.waitingDialog(context, wallet.pull, snackKey);
      try {
        await wallet.getBalanace();
        await wallet.getTransactions();
        if(wallet.transactions.length==0) {
          message = 'This wallet is Empty, make some transactions';
        }
      } catch (e) {
        message = 'you need to pull your wallet';
      }
      loadValues();
      setState((){});
    } catch(ex) {
      await Dialogs.messageDialog(context, 'error', ex.toString(), snackKey, false);
    }
  }

  Future<void> restart() async {
    DialogResult res = await Dialogs.messageDialog(context, 'Sure?',
    'the old wallet will be lost forever', snackKey, true);
    if(res==DialogResult.OK) {
      await Dialogs.waitingDialog(context, wallet.restart, snackKey,
      returnsJobId: false);
      await wallet.restart();
      String keygap = await wallet.getKeyGap();
      DialogResult res = await Dialogs.messageDialog(context, "Confirm", "You keygap is: $keygap please save it in a safe place\n"
        + "once you press okay it will be deleted from WTS server", snackKey, true);
      if(res==DialogResult.OK) {
        await wallet.confirm();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('key', '0');
      }
    }
  }

  void loadValues() {
    this.id = wallet.id==null?"null":wallet.id;
    this.balance = wallet.balanceZents=="pull"?
      "Pulling, refresh in a minute":
      (double.parse(wallet.balanceZents)/pow(2,32)).toStringAsFixed(3) +
      " ZLD";
    this.balanceZent =wallet.balanceZents + " Zents";
    transactions.clear();
    transactions.addAll(wallet.transactions);
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', '0');
    await prefs.setString('keygap', '0');
    Navigator.of(context).pushReplacementNamed('/login');
  }
}