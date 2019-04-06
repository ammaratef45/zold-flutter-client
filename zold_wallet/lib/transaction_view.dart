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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text('#' + transaction.id.toString()),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(transaction.amount()),
              ),
              Text(transaction.timeAgo())
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(transaction.sender + ": " + transaction.details),
              ),
            ],
          ),
        ],
      ),
    );
    return widget;
  }
  
}