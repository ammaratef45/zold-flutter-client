import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zold_wallet/home_page/home_page.dart';
import 'package:zold_wallet/transaction.dart';
import 'dart:math';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/wallet.dart';


abstract class HomePageViewModel extends State<HomePage> {
  Wallet wallet = Wallet.wallet;
  String id = "";
  String balance = "";
  String balanceZent = "";
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();
  var snackKey = GlobalKey<ScaffoldState>();
  List<Transaction> transactions =List();

  HomePageViewModel() {
    refresh();
  }

  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  Future<void> refresh() async {
    try {
      await wallet.getId();
      await Dialogs.waitingDialog(context, wallet.pull, snackKey, wallet);
      await wallet.getBalanace();
      await wallet.getTransactions();
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
    Navigator.of(context).pushReplacementNamed('/login');
  }
}