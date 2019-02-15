import 'package:flutter/material.dart';
import './home_page.dart';
import './backend/API.dart';

abstract class HomePageViewModel extends State<HomePage> {
  String idText = "ID";
  String balanceText = "Balance";
  final apiKeyController = TextEditingController();
  API api = API();

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  void getId() {
    api.getId(apiKeyController.text)
    .then((id){
      setState(() {
        idText = id;
      });
    })
    .catchError((ex){
      setState(() {
        idText = "ID: error";
      });
    });
  }

  void getBalance() {
    api.getBalance(apiKeyController.text)
    .then((balance){
      debugPrint(balance);
      setState(() {
        balanceText = balance;
      });
    })
    .catchError((ex){
      setState(() {
        balanceText = "Balance: error";
      });
    });
  }

  void pullWallet() {
    api.pull(apiKeyController.text)
    .then((response){
      debugPrint(response);
    })
    .catchError((ex){
    });
  }
}