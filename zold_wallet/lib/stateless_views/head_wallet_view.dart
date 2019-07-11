import 'package:flutter/material.dart';
import 'package:zold_wallet/backend/head.dart';

/// the main info of wallet.
class HeadWalletView extends StatelessWidget {
  /// constructor
  const HeadWalletView(this._head, {this.copyCallback});

  final Head _head;

  static const TextStyle _style = TextStyle(color: Color(0xff1970b6));

  /// the callback when copy is clicked
  final VoidCallback copyCallback;

  @override
  Widget build(BuildContext context) => Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Text(
                        'Id',
                        style: _style,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: copyCallback,
                        child: const Icon(
                          Icons.content_copy,
                        ),
                      ),
                    ],
                  ),
                  Text(_head.id),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Debt',
                    style: _style,
                  ),
                  Text(_head.debt()),
                ],
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Transactions',
                    style: _style,
                  ),
                  Text(_head.txns.toString()),
                ],
              ),
            ]),
      );
}
