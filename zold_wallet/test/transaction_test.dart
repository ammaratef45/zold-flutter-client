
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:zold_wallet/transaction.dart';

import 'transaction_data.dart';

void main() {
  Map<String, dynamic> values = Map<String, dynamic>();
  values["id"] = 123;
  values["date"] = '2019-04-07T07:42:57Z';
  values["amount"] = 12;
  values["details"] = 'test';
  values["bnf"] = '25a9cac1715a3726';
  Transaction t1 = Transaction.fromJson(values);
  values["date"] = '2020-04-07T07:42:57Z';
  Transaction t2 = Transaction.fromJson(values);
  test('test is before', () {
    expect(t1.isAfter(t2), false);
  });

  test('test creating list', () {
    List<dynamic> map = json.decode(TransactionData.listStringDumb);
    expect(map, isNotNull);
    Transaction last = Transaction.fromJson(map[0]);
    for (var i = 1; i < map.length; i++) {
      Transaction t = Transaction.fromJson(map[i]);
      expect(t.isAfter(last), false);
      last = t;
    }
    List<Transaction> transactionList = Transaction.fromJsonList(map);
    expect(transactionList.length, isNonZero);
    for(int i=0; i<transactionList.length-1; i++) {
      expect(transactionList[i+1].isAfter(transactionList[i]), false);
    }
  });
}