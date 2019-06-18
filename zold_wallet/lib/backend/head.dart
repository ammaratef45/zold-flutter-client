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

  /// ID of the wallet.
  String get id => _id;
  num _size;
  num _balance;

  /// Wallet's balance in zents.
  num get balance => _balance;
  num _txns;
  num _taxes;
  num _debt;
}
