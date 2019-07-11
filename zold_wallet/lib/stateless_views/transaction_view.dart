import 'package:flutter/material.dart';
import 'package:zold_wallet/transaction.dart';

/// transaction record.
class TransactionView extends StatelessWidget {
  /// constructor
  const TransactionView(this.transaction);

  /// model of the view
  final Transaction transaction;

  static const TextStyle _noramlTextStyle = TextStyle(color: Color(0xff707070));
  static const TextStyle _timeTextStyle = TextStyle(color: Color(0xff2196f3));

  @override
  Widget build(BuildContext context) => Card(
          child: Container(
        margin: const EdgeInsets.only(top: 10, left: 2, right: 2),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    transaction.amount(),
                    style: TextStyle(
                      color: Color(
                          transaction.zents > 0 ? 0xFF09BB2D : 0xFFD40000),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: Text(
                  transaction.details,
                  style: _noramlTextStyle,
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    transaction.sender,
                    style: _noramlTextStyle,
                  ),
                ),
                Flexible(
                  child: Text(
                    transaction.timeAgo(),
                    style: _timeTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}
