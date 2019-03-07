import 'package:flutter/material.dart';
import './home_page.dart';
import '../wallet.dart';
import 'dart:math';

abstract class HomePageViewModel extends State<HomePage> {
  Wallet wallet = Wallet.wallet;

  HomePageViewModel() {
    
  }

  void showMessageDialog(String message) {}

  @override
  void dispose() {
    super.dispose();
  }
}