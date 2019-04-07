import 'package:flutter/material.dart';
typedef StringCallback = void Function(String);
class PhoneView extends StatelessWidget {
  final StringCallback onSendCode;
  final VoidCallback authCallback;
  final phoneController = TextEditingController();
  PhoneView({this.onSendCode, this.authCallback});
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
            'Enter your mobile phone number (digits only) and'
            +' we will send you a secret code in a few seconds:',
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
              Text(
                '+',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 2),
                width: 220,
                child: TextFormField(
                  controller: phoneController,
                  //keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Digits only...',
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
              onSendCode(phoneController.text);
            },
            color: Colors.blue,
            child: Text("Send me the code"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          InkWell(
            child: Text(
              'Login with an API token',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: authCallback,
          )
        ],
      )
    );
  }

}
