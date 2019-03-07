import 'package:flutter/material.dart';
import './home_page.dart';
import '../wallet.dart';
import 'dart:math';

abstract class HomePageViewModel extends State<HomePage> {
  Wallet wallet = Wallet.wallet;
  String id = "";
  String balance = "";
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();

  HomePageViewModel();

  void showMessageDialog(String message) {}

  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  void refresh() {
    wallet.pull();
    wallet.getId();
    wallet.getBalanace();
    loadValues();
    setState((){});
  }

  void loadValues() {
    this.id = wallet.id==null?"null":wallet.id;
    this.balance = wallet.balanceZents=="pull"?
      "Pulling, refresh in a minute":
      (double.parse(wallet.balanceZents)/pow(2,32)).toString() +
      " ZLD" +
      "(" +
      wallet.balanceZents + " Zents" +
      ")";
  }

  void pay(String bnf, String amount, String details, String keygap) async {
    showMessageDialog("Sending...");
    await wallet.pay(bnf, amount, details, keygap);
    showMessageDialog("We sent your request");
  }
}