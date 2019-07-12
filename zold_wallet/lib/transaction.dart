/*
 "id": 239,\n
 "date": "2019-01-13T15:42:17Z",\n'
 "amount": 1099511627,\n'
 "prefix": "CAQ8AMII",\n'
 "bnf": "e5b5fc7379d80ed7",\n'
 "details": "WTS signup bonus to ammaratef45",\n
 "sign": null,
 "tid": "e5b5fc7379d80ed7:239"
 */
import 'dart:math';
import 'package:timeago/timeago.dart' as timeago;

/// Transaction model
class Transaction {
  /// ctor
  Transaction.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _date = map['date'];
    _zents = map['amount'];
    _details = map['details'];
    _sender = map['bnf'];
  }
  num _id;

  /// transaction id
  num get id => _id;

  String _date;

  /// transaction date
  String get date => _date;

  num _zents;

  /// amount in zents
  num get zents => _zents;

  String _details;

  /// details of transaction
  String get details => _details;

  String _sender;

  /// sender wallet
  String get sender => _sender;

  /// create list of transactions
  static List<Transaction> fromJsonList(List<dynamic> list) {
    final List<Transaction> result = <Transaction>[];
    for (int i = 0; i < list.length; i++) {
      result.add(Transaction.fromJson(list[i]));
    }
    return result;
  }

  /// get amount in zold
  String amount() => (zents / pow(2, 32)).toStringAsFixed(2);

  /// get transaction date in timeAgo format
  String timeAgo() {
    final DateTime datetime = dateTime();
    return timeago.format(datetime);
  }

  /// get datetime parsing date property
  DateTime dateTime({bool trunc = false}) {
    if (trunc) {
      return DateTime.tryParse(date.split('T')[0]);
    } else {
      return DateTime.tryParse(date);
    }
  }

  /// is transaction after another one?
  bool isAfter(Transaction other) =>
      dateTime(trunc: true).isAfter(other.dateTime());

  /// is transaction before another one?
  int compare(Transaction other) =>
      dateTime().difference(other.dateTime()).inSeconds;
}
