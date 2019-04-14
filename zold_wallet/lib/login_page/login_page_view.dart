import 'package:flutter/material.dart';
import 'package:zold_wallet/auth_view.dart';
import 'package:zold_wallet/code_view.dart';
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
                authCallback: (){
                  setState(() {
                    page = CurrentVisiblePage.authPage;
                  });
                },
              ),
            ),
            Visibility(
              visible: page==CurrentVisiblePage.codePage,
              child: CodeView(
                onLogin: loginPhone,
                backCallback: (){
                  setState(() {
                    page = CurrentVisiblePage.phonePage;
                  });
                },
              ),
            ),
            Visibility(
              visible: page==CurrentVisiblePage.authPage,
              child: AuthView(
                onLogin: loginWithKey,
                phoneCallback: (){
                  setState(() {
                    page = CurrentVisiblePage.phonePage;
                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

}