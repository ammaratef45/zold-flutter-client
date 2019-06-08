import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';

typedef StringCallback = void Function(String);

/// PhoneView is the view that propmt for the phone number.
class PhoneView extends StatelessWidget {
  /// constructor
  PhoneView({this.onSendCode, this.authCallback});

  /// onSendCode callback will execute when send code being clicked.
  final StringCallback onSendCode;

  /// authCallback will execute when pressing login with auth.
  final VoidCallback authCallback;

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Image.asset(
            'assets/icon/icon.png',
            fit: BoxFit.contain,
            height: 84,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Text('Login', style: Theme.of(context).textTheme.title),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Text('Use your Mobile number to verify your login by SMS code.',
              style: Theme.of(context).textTheme.subtitle),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ZoldTextField(
                controller: _phoneController,
                hint: 'Enter your mobile number',
                width: 300,
                prefixIcon: Icons.add,
                keyboardType: TextInputType.number,
                isDigitsOnly: true,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 22),
          ),
          MaterialButton(
            color: Theme.of(context).accentColor,
            minWidth: 200,
            height: 40,
            onPressed: () {
              onSendCode(_phoneController.text);
            },
            child: const Text('Send'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
          ),
          InkWell(
            child: Text(
              'Or login with an API token',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: authCallback,
          )
        ],
      ));
}
