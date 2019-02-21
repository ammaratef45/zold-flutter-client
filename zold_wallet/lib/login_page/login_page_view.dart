import './login_page_view_model.dart';
import 'package:flutter/material.dart';

class LoginPageView extends LoginPageViewModel {

  @override showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Error, try again later"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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