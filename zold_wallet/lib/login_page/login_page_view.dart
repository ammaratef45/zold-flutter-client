import 'package:flutter/material.dart';
import 'package:zold_wallet/login_page/login_page_view_model.dart';
import 'package:zold_wallet/phone_view.dart';

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
            Visibility(
              visible: page==CurrentVisiblePage.phonePage,
              child: PhoneView(
                onSendCode: getCode,
              ),
            ),
            Visibility(
              visible: page==CurrentVisiblePage.codePage,
              child: Row(
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
                  
                ],
              ),
            ),
            Visibility(
              visible: page==CurrentVisiblePage.authPage,
              child: TextField(
                controller: apiKeyController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'API Key'
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}