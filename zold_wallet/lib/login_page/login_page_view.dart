import './login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginPageView extends LoginPageViewModel {

  @override showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Ooh"),
          content: new Text(message),
          actions: <Widget>[
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
                    decoration: InputDecoration(
                      hintText: 'Phone Number'
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: secretCodeController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Secret Code'
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: getCode,
                  child: Text("Get Code"),
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