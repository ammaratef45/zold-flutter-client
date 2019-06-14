import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
typedef StringCallback = void Function(String);

/// view that prompt for api key
class AuthView extends StatelessWidget {
  /// constructor
  AuthView(
    {
      this.onLogin,
      this.phoneCallback
    }
  );

  /// callback for login pressed
  final StringCallback onLogin;
  /// callback for pressing login with phone number
  final VoidCallback phoneCallback;

  final TextEditingController _tokenController = TextEditingController();
  
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
          const Text(
            'Enter your API token:',
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 4),
              ),
              ZoldTextField(
                width: 240,
                controller: _tokenController,
                hint: 'Token...',
                label: 'Token',
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          RaisedButton(
            onPressed: (){
              onLogin(_tokenController.text);
            },
            color: Colors.blue,
            child: const Text('Login'),
          ),
          const Padding(
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
