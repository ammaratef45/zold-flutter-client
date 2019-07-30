import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
import 'package:zold_wallet/stateless_views/title_text.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const TitleText('Send ZLD'),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Balance: ${Wallet.instance().balance()}',
              style: const TextStyle(color: Colors.green, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            ZoldTextField(
              controller: controllers['bnfController'],
              hint: 'bnf',
            ),
            const SizedBox(
              height: 10,
            ),
            ZoldTextField(
              controller: controllers['amountController'],
              hint: 'Amount',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ZoldTextField(
                  controller: controllers['keygapController'],
                  hint: 'keygap',
                ),
                Visibility(
                    visible: keyGapAvailable,
                    child: IconButton(
                      icon: const Icon(Icons.fingerprint),
                      onPressed: authCallback,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ZoldTextField(
              controller: controllers['messageController'],
              hint: 'Details',
            ),
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: const Text(
                'Go back to home screen',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}
