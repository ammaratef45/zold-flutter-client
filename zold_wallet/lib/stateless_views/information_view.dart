import 'package:flutter/material.dart';

/// the main info of wallet.
class InformationView extends StatelessWidget {
  /// constructor
  const InformationView(
      {this.idText = '',
      this.balanceText = '',
      this.balanceZents = '',
      this.balanceUSD = '',
      this.copyCallback,
      this.transactions});

  /// The text represents the wallet id
  final String idText;

  /// The text represents the balance of the wallet
  final String balanceText;

  /// Balance in zents as a String
  final String balanceZents;

  /// Balance in USD as a String
  final String balanceUSD;

  /// Transactions count
  final num transactions;

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
                  child: Text(idText),
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
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(balanceZents)));
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
                  Text('Transactions: $transactions'),
                ],
              ),
            ),
          ],
        ),
      );
}
