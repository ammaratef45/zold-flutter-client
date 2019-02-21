import './login_page_view_model.dart';
import 'package:flutter/material.dart';

class LoginPageView extends LoginPageViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zold"),
      ),
      body: Center(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: apiKeyController,
              ),
              RaisedButton(
                onPressed: pullWallet,
                child: Text("Pull"),
              )
            ],
          )
        ),
      ),
    );
  }

}