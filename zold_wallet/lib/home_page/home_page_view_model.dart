import 'package:flutter/material.dart';
import 'package:zold_wallet/transaction.dart';
import './home_page.dart';
import '../wallet.dart';
import 'dart:math';
import 'package:zold_wallet/dialogs.dart';


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
    await wallet.getId();
    await Dialogs.waitingDialog(context, wallet.pull, snackKey, wallet);
    await wallet.getBalanace();
    await wallet.getTransactions();
    loadValues();
    setState((){});
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
}