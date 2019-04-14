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
        children: <Widget>[
          ZoldTextField(
            controller: _bnfController,
            width: 210,
            hint: 'bnf: eg. ammaratef45',
          ),
          ZoldTextField(
            controller: _amountController,
            width: 210,
            hint: 'Amount: eg. 1.2',
          ),
          Text(
            'Balance: ${Wallet.instance().balance()}',
            style: TextStyle(
              color: Colors.red
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ZoldTextField(
                controller: _keygapController,
                width: 210,
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
            width: 210,
            hint: 'Details: eg. for selling me the book',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
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
              RaisedButton(
                onPressed: (){
                  _bnfController.clear();
                  _amountController.clear();
                  _messageController.clear();
                  _keygapController.clear();
                },
                child: const Text('Clear'),
              ),
            ],
          )
        ],
      ),
    );
    
}
