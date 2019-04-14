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

class Transaction {
 num _id;
 num get id => _id;

 String _date;
 String get date => _date;

 num _zents;
 num get zents => _zents;

 String _details;
 String get details => _details;

 String _sender;
 String get sender => _sender;

 Transaction.fromJson(Map<String, dynamic> map) {
   this._id = map["id"];
   this._date = map["date"];
   this._zents = map["amount"];
   this._details = map["details"];
   this._sender = map["bnf"];
 }

 static List<Transaction> fromJsonList(List<dynamic> list) {
   List<Transaction> result =List();
   for (var i = 0; i < list.length; i++) {
     result.add(Transaction.fromJson(list[i]));
   }
   return result;
 }

  String amount() {
    return (zents/pow(2,32)).toStringAsFixed(2);
  }

  String timeAgo() {
    final datetime = this.dateTime();
    return timeago.format(datetime);
  }

  DateTime dateTime({bool trunc=false}) {
    if(trunc) {
      return DateTime.tryParse(this.date.split('T')[0]); 
    } else {
      return DateTime.tryParse(this.date); 
    }
  }

  bool isAfter(Transaction other) {
    return this.dateTime(trunc: true).isAfter(other.dateTime());
  }

  int compare(Transaction other) {
    return this.dateTime().difference(other.dateTime()).inSeconds;
  }

}