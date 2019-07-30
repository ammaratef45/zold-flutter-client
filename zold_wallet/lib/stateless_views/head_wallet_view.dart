import 'package:flutter/material.dart';
import 'package:zold_wallet/backend/head.dart';

/// the main info of wallet.
class HeadWalletView extends StatelessWidget {
  /// constructor
  const HeadWalletView(this._head, {this.copyCallback});

  final Head _head;

  static const TextStyle _style = TextStyle(color: Color(0xff1970b6));
  static const TextStyle _noramlTextStyle = TextStyle(color: Color(0xff707070));

  /// the callback when copy is clicked
  final VoidCallback copyCallback;

  @override
  Widget build(BuildContext context) => Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      _head.id,
                      style: _noramlTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Debt',
                    style: _style,
                  ),
                  Text(
                    _head.debt(),
                    style: _noramlTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                width: 6,
              ),
              Column(
                children: <Widget>[
                  const Text(
                    'Transactions',
                    style: _style,
                  ),
                  Text(
                    _head.txns.toString(),
                    style: _noramlTextStyle,
                  ),
                ],
              ),
            ]),
      );
}
