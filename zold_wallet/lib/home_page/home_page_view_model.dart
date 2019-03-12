import 'package:flutter/material.dart';
import './home_page.dart';
import '../wallet.dart';
import 'dart:math';
typedef Future<void> WaitingCallback();
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

  void showWaitingDialog(WaitingCallback callback) async {}

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  Future<void> refresh() async {
    await wallet.pull();
    await wallet.getId();
    await wallet.getBalanace();
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