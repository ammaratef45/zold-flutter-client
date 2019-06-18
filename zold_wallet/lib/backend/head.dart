import 'dart:convert';

/// wallet head.
class Head {
  /// Constructor.
  Head.fromJsonString(String jsonString) {
    final Map<String, dynamic> map = json.decode(jsonString);
    _id = map['id'];
    _size = map['size'];
    _balance = map['balance'];
    _txns = map['txns'];
    _taxes = map['taxes'];
    _debt = map['debt'];
  }
  String _id;
  num _size;
  num _balance;
  num _txns;
  num _taxes;
  num _debt;
}
