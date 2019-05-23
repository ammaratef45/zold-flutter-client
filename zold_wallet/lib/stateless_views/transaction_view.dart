import 'package:flutter/material.dart';
import 'package:zold_wallet/transaction.dart';

/// transaction record.
class TransactionView extends StatelessWidget {
  /// constructor
  const TransactionView(
    this.transaction
  );
  /// model of the view
  final Transaction transaction;

  @override
  Widget build(BuildContext context) =>
    Container(
      margin: const EdgeInsets.only(top: 10, left: 2, right: 2),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text('#${transaction.id.toString()}'),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Text(
                  transaction.amount(),
                  style: TextStyle(
                    color: Color(transaction.zents>0?0xFF00FF00:0xFFFF0000),
                  ),
                ),
              ),
              Text(transaction.timeAgo())
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text('${transaction.sender}: ${transaction.details}'),
              ),
            ],
          ),
        ],
      ),
    );

}