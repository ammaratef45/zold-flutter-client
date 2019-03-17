import 'package:flutter/material.dart';
import './home_page.dart';
import '../wallet.dart';
import 'dart:math';
import '../wts_log.dart';
import '../payment.dart';

typedef Future<WtsLog> WaitingCallback();
abstract class HomePageViewModel extends State<HomePage> {
  Wallet wallet = Wallet.wallet;
  String id = "";
  String balance = "";
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();

  HomePageViewModel() {
    refresh();
  }

  void showMessageDialog(String message) {}

  Future<void> showWaitingDialog(WaitingCallback callback) async {}

  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  Future<void> refresh() async {
    await wallet.getId();
    await wallet.getBalanace();
    if(wallet.balanceZents=="pull")
      await showWaitingDialog(wallet.pull);
    loadValues();
    setState((){});
  }

  void loadValues() {
    this.id = wallet.id==null?"null":wallet.id;
    this.balance = wallet.balanceZents=="pull"?
      "Pulling, refresh in a minute":
      (double.parse(wallet.balanceZents)/pow(2,32)).toStringAsFixed(3) +
      " ZLD" +
      "(" +
      wallet.balanceZents + " Zents" +
      ")";
  }

  void pay(String bnf, String amount, String details, String keygap) async {
    Payment payment =Payment(bnf, amount, details, keygap);
    await showWaitingDialog(payment.doPay);
  }
}