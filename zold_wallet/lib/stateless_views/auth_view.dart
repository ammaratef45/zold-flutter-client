import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
typedef StringCallback = void Function(String);
class AuthView extends StatelessWidget {
  final StringCallback onLogin;
  final VoidCallback phoneCallback;
  final tokenController = TextEditingController();
  AuthView({this.onLogin, this.phoneCallback});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Image.asset(
            'assets/icon/icon.png',
            fit: BoxFit.contain,
            height: 64,
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Text(
            'Enter your API token:',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 4),
              ),
              ZoldTextField(
                width: 240,
                controller: tokenController,
                hint: 'Token...',
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          RaisedButton(
            onPressed: (){
              onLogin(tokenController.text);
            },
            color: Colors.blue,
            child: Text("Login"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          InkWell(
            child: Text(
              'Login with mobile phone',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: phoneCallback,
          )
        ],
      )
    );
  }

}
