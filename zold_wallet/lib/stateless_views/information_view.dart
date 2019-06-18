import 'package:flutter/material.dart';
import 'package:zold_wallet/backend/head.dart';

/// the main info of wallet.
class InformationView extends StatelessWidget {
  /// constructor
  const InformationView(this._head,
      {this.balanceText = '', this.balanceUSD = '', this.copyCallback});

  final Head _head;

  /// The text represents the balance of the wallet
  final String balanceText;

  /// Balance in USD as a String
  final String balanceUSD;

  /// the callback when copy is clicked
  final VoidCallback copyCallback;
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('ID: '),
                Flexible(
                  child: Text(_head.id),
                ),
                GestureDetector(
                  onTap: copyCallback,
                  child: const Icon(
                    Icons.content_copy,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                children: <Widget>[
                  const Text('Balance: '),
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(_head.balance.toString())));
                    },
                    child: Text('$balanceText ($balanceUSD)'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 18),
              child: Row(
                children: <Widget>[
                  Text('Transactions: ${_head.txns}'),
                ],
              ),
            ),
          ],
        ),
      );
}
