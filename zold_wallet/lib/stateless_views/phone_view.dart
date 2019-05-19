import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
typedef StringCallback = void Function(String);
/// PhoneView is the view that propmt for the phone number. 
class PhoneView extends StatelessWidget {
  /// constructor
  PhoneView(
    {
      this.onSendCode,
      this.authCallback
    }
  );

  /// onSendCode callback will execute when send code being clicked.
  final StringCallback onSendCode;
  /// authCallback will execute when pressing login with auth.
  final VoidCallback authCallback;

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
    Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Image.asset(
            'assets/icon/icon.png',
            fit: BoxFit.contain,
            height: 64,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Text(
            'Enter your mobile phone number (digits only) and'
            ' we will send you a secret code in a few seconds:',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 4),
              ),
              Text(
                '+',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              ZoldTextField(
                controller: _phoneController,
                hint: 'Digits only...',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          RaisedButton(
            onPressed: (){
              onSendCode(_phoneController.text);
            },
            color: Colors.blue,
            child: const Text('Send me the code'),
          ),
          const Padding(
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
