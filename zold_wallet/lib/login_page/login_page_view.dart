import './login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

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

  @override showCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Code"),
          content: Column(
            children: <Widget>[
              Text("Enter the secret code received in sms:"),
              TextField(
                controller: secretCodeController,
                keyboardType: TextInputType.number,
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                getApiKey();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
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
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CountryCodePicker(
                  onChanged: pickedCode,
                  initialSelection: 'EG',
                  favorite: ['+20','EG'],
                ),
                Flexible(
                  child: TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: loginPhone,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

}