import 'dart:convert';

import 'dart:math';

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
  num get size => _size;
  num _balance;

  /// Wallet's balance in zents.
  num get balance => _balance;
  num _txns;

  /// Number of transactions.
  num get txns => _txns;
  num _taxes;
  num _debt;

  /// Return taxes in ZLD.
  String taxes() => (_taxes / pow(2, 32)).toStringAsFixed(2);

  /// Return debt in ZLD.
  String debt() => (_debt / pow(2, 32)).toStringAsFixed(2);
}
