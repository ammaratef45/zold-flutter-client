import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:zold_wallet/login_page/login_page_view_model.dart';

class LoginPageView extends LoginPageViewModel {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
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
            Text("OR"),
            TextField(
              controller: apiKeyController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'API Key'
              ),
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