import 'package:flutter/material.dart';
import 'package:zold_wallet/stateless_views/diagonal_clipper.dart';

/// the main info of wallet.
class InformationView extends StatelessWidget {
  /// constructor
  const InformationView(
      {this.balanceText = '', this.balanceUSD = '', this.balanceZents = ''});

  /// The text represents the balance of the wallet
  final String balanceText;

  /// Balance in USD as a String
  final String balanceUSD;

  /// Balance in zents
  final String balanceZents;

  static const TextStyle _style = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) => Container(
        child: ClipPath(
          clipper: DiagonalClipper(),
          child: Container(
            decoration: const BoxDecoration(color: Color(0xff2196f3)),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  balanceZents,
                  style: _style,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '$balanceText($balanceUSD)',
                  style: _style,
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      );
}
