import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
typedef StringCallback = void Function(String);
/// view that prompt for code to authenticate
class CodeView extends StatelessWidget {
  /// constructor
  CodeView(
    {
      this.onLogin,
      this.backCallback
    }
  );
  /// callback when login clicked
  final StringCallback onLogin;
  /// callback when back clicked
  final VoidCallback backCallback;
  final TextEditingController _codeController = TextEditingController();
  
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
            'Enter the code you received to your mobile phone'
            ' via in the text message we just sent you (four digits):'
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
                controller: _codeController,
                width: 110,
                hint: 'Code',
                label: 'Code',
              ),  
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          RaisedButton(
            onPressed: (){
              onLogin(_codeController.text);
            },
            color: Colors.blue,
            child: const Text('Login'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 18),
          ),
          InkWell(
            child: Text(
              'Go back and try again',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: backCallback,
          )
        ],
      )
    );

}
