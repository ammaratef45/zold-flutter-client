import 'package:flutter/material.dart';
import './login_page.dart';
import '../backend/API.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  final apiKeyController = TextEditingController();
  API api = API();
  
  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  showErrorDialog() {}

  void pullWallet() {
    api.pull(apiKeyController.text)
    .then((response){
      debugPrint(response);
    })
    .catchError((ex){
      debugPrint(ex.toString());
      showErrorDialog();
    });
  }
}