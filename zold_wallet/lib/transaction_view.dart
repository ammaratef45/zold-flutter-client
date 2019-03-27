import 'package:flutter/material.dart';
import 'package:zold_wallet/transaction.dart';

class TransactionView extends StatelessWidget {
  final Transaction transaction;
  TransactionView(
    this.transaction
  );

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      margin: EdgeInsets.only(top: 10, left: 2, right: 2),
      color: Color(transaction.zents>0?0xFF00FF00:0xFFFF0000),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(transaction.date),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(transaction.sender),
              Text(transaction.amount() + 'ZLD'),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(transaction.details),
            ],
          ),
        ],
      ),
    );
    return widget;
  }
  
}