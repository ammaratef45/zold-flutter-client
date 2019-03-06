import 'package:flutter/material.dart';
import './home_page.dart';
import '../wallet.dart';

abstract class HomePageViewModel extends State<HomePage> {
  String idText = "ID";
  String balanceText = "Balance";
  Wallet wallet = Wallet.loggedInWallet;

  HomePageViewModel() {
    wallet.pull();
    getId();
    getBalance();
  }

  void showMessageDialog(String message) {}

  @override
  void dispose() {
    super.dispose();
  }

  void getId() {
    wallet.getId()
      .then((id){
        setState(() {
          idText = id;
        });
      })
      .catchError((error){
        showMessageDialog(error.toString());
        setState(() {
          idText = "ID: error";
        });
      });
  }

  void getBalance() {
    wallet.getBalanace()
      .then((balance) {
        setState(() {
          balanceText = balance;
        });
      })
      .catchError((error){
        showMessageDialog(error.toString());
        setState(() {
          balanceText = "Balance: error";
        });
      });
  }

  void refresh() {
    wallet.pull();
    getId();
    getBalance();
  }
}