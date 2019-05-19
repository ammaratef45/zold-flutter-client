import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/auth_view.dart';
import 'package:zold_wallet/stateless_views/code_view.dart';
import 'package:zold_wallet/login_page/login_page_view_model.dart';
import 'package:zold_wallet/stateless_views/phone_view.dart';
/// LoginPageView
class LoginPageView extends LoginPageViewModel {
  
  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomPadding: true,
      key: snackKey,
      body: Container(
        child: SingleChildScrollView(
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
      ),
    );

}