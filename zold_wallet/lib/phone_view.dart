import 'package:flutter/material.dart';
typedef StringCallback = void Function(String);
class PhoneView extends StatelessWidget {
  final StringCallback onSendCode;
  final phoneController = TextEditingController();
  PhoneView({this.onSendCode});
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
            'To login you need to give us your phone number\n'
            +'we will send you a secret code',
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
              Text('+'),
              
              Container(
                padding: EdgeInsets.only(left: 2),
                width: 140,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
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
        ],
      )
    );
  }

}