import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
import 'package:zold_wallet/wallet.dart';

typedef PayCallback = void Function(
  String bnf, String amount, String details, String keygap
);

/// payview that prompt for pay details
class PayView extends StatelessWidget {
  /// constructor
  PayView({
    this.payCallback,
    this.authCallback,
    this.keyGapAvailable
  });

  final TextEditingController _bnfController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _keygapController = TextEditingController();
  /// callback when pressing pay
  final PayCallback payCallback;
  /// callback when fingerprint is clicked
  final VoidCallback authCallback;
  /// determine if keygap is available in shared preferences
  final bool keyGapAvailable;

  @override
  Widget build(BuildContext context) =>
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ZoldTextField(
            controller: _bnfController,
            width: 210,
            hint: 'bnf: eg. ammaratef45',
          ),
          ZoldTextField(
            controller: _amountController,
            width: 150,
            hint: 'Amount: eg. 1.2',
          ),
          Text(
            'Balance: ${Wallet.instance().balance()}',
            style: TextStyle(
              color: Colors.red
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ZoldTextField(
                controller: _keygapController,
                width: 110,
                hint: 'keygap',
              ),
              Visibility(
                visible: keyGapAvailable,
                child: IconButton(
                  icon: const Icon(Icons.fingerprint),
                  onPressed: authCallback,
                )
              )
            ],
          ),
          ZoldTextField(
            controller: _messageController,
            width: 310,
            hint: 'Details: eg. for selling me the book',
          ),
          RaisedButton(
            onPressed: (){
              payCallback(
                _bnfController.text,
                _amountController.text,
                _messageController.text,
                _keygapController.text
              );
            },
            child: const Text('Send'),
          ),
           InkWell(
            child: Text(
              'Go back to home screen',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: ()=>Navigator.pop(context),
          ),
        ],
      ),
    );
    
}
