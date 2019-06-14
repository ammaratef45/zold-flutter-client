import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
import 'package:zold_wallet/wallet.dart';

typedef PayCallback = void Function(
    String bnf, String amount, String details, String keygap);

/// payview that prompt for pay details
class PayView extends StatelessWidget {
  /// constructor
  const PayView(
      {this.payCallback,
      this.authCallback,
      this.keyGapAvailable,
      this.controllers});

  /// controllers of text editors
  final Map<String, TextEditingController> controllers;

  /// callback when pressing pay
  final PayCallback payCallback;

  /// callback when fingerprint is clicked
  final VoidCallback authCallback;

  /// determine if keygap is available in shared preferences
  final bool keyGapAvailable;

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Send ZLD'),
            const SizedBox(
              height: 10,
            ),
            ZoldTextField(
              controller: controllers['bnfController'],
              width: 210,
              hint: 'bnf: eg. ammaratef45',
              label: 'bnf',
            ),
            ZoldTextField(
              controller: controllers['amountController'],
              width: 150,
              hint: 'Amount: eg. 1.2',
              label: 'Amount',
            ),
            Text(
              'Balance: ${Wallet.instance().balance()}',
              style: TextStyle(color: Colors.red),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ZoldTextField(
                  controller: controllers['keygapController'],
                  width: 110,
                  hint: 'keygap',
                  label: 'keygap',
                ),
                Visibility(
                    visible: keyGapAvailable,
                    child: IconButton(
                      icon: const Icon(Icons.fingerprint),
                      onPressed: authCallback,
                    ))
              ],
            ),
            ZoldTextField(
              controller: controllers['messageController'],
              width: 310,
              hint: 'Details: eg. for selling me the book',
              label: 'Details',
            ),
            RaisedButton(
              onPressed: () {
                payCallback(
                    controllers['bnfController'].text,
                    controllers['amountController'].text,
                    controllers['messageController'].text,
                    controllers['keygapController'].text);
              },
              child: const Text('Send'),
            ),
            InkWell(
              child: Text(
                'Go back to home screen',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}
