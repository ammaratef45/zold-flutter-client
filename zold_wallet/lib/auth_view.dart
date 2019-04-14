import 'package:flutter/material.dart';
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
              Container(
                padding: EdgeInsets.only(left: 2),
                width: 240,
                child: TextField(
                  controller: tokenController,
                  //keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Token...',
                    border: OutlineInputBorder()
                  ),
                ),
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
