import 'package:flutter/material.dart';
typedef StringCallback = void Function(String);
class CodeView extends StatelessWidget {
  final StringCallback onLogin;
  final VoidCallback backCallback;
  final codeController = TextEditingController();
  CodeView({this.onLogin, this.backCallback});
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
            'Enter the code you got in SMS',
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
                width: 110,
                child: TextField(
                  controller: codeController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Code',
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
              onLogin(codeController.text);
            },
            color: Colors.blue,
            child: Text("Login"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          InkWell(
            child: Text(
              'Go Back',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: backCallback,
          )
        ],
      )
    );
  }

}