import 'package:flutter/material.dart';
import '../wallet.dart';
import 'dart:math';

abstract class InformationViewModel extends StatelessWidget {
  String idText = "";
  String balanceText = "";
  Wallet wallet = Wallet.wallet;
  InformationViewModel() {
    refresh();
  }
  void refresh() {
    wallet.pull();
    idText = wallet.id==null? "":wallet.id;
    balanceText = wallet.balanceZents==null?
      "we are pulling, refresh in a minute":
      (double.parse(wallet.balanceZents)/(pow(2,32))).toString() + " ZLD" + 
      "(" +
      wallet.balanceZents + " Zents" + 
      ")";
  }
}