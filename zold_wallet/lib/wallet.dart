import 'dart:convert';
import 'dart:math';

import 'package:zold_wallet/backend/head.dart';
import 'package:zold_wallet/invoice.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/transaction.dart';

import 'backend/api.dart';
import 'wts_log.dart';

/// wallet.
class Wallet {
  Wallet._();

  /// wallet api key.
  String apiKey = '';

  /// wallet keygap.
  String keygap = '';

  Head _head = Head.nullHead();

  /// Head info of wallet.
  Head get head => _head;

  /// phone number of wallet.
  String phone = '';
  API _api = API();

  /// wallet's list of transactions.
  List<Transaction> transactions = <Transaction>[];

  /// wallet's conversion rate.
  String rate = 'rate';
  static Wallet _wallet;

  /// get instance of the wallet.
  static Wallet instance() => _wallet ??= Wallet._();

  /// change wallet's phone.
  void changePhone(String phone) {
    this.phone = phone;
  }

  /// update wallet's info.
  Future<void> update() async {
    await updateHead();
    await updateTransactions();
    await updateRate();
  }

  /// Sends the verification message.
  Future<String> sendCode() async => _api.getCode(phone);

  /// Check if we got the key.
  bool keyLoaded() => apiKey != null && apiKey != '';

  /// Get the key.
  Future<void> getKey(String code) async {
    apiKey = await _api.getToken(phone, code);
  }

  /// Get an invoice.
  Future<Invoice> invoice() async => _api.invoice(apiKey);

  /// Confirm the keygap.
  Future<void> confirm() async {
    await _api.confirm(apiKey, keygap);
  }

  /// Check if keygap is confirmed.
  Future<bool> confirmed() async => await _api.confirmed(apiKey) == 'yes';

  /// Get the keygap.
  Future<String> getKeyGap() async => _api.keygap(apiKey);

  /// Pull the wallet.
  Future<String> pull() async => _api.pull(apiKey);

  /// Restart the wallet.
  Future<String> restart() async => _api.recreate(apiKey);

  /// Update head info.
  Future<void> updateHead() async {
    _head = await _api.head(apiKey);
  }

  /// Update the list of transactions.
  Future<void> updateTransactions() async {
    final String response = await _api.transactions(apiKey);
    final List<Transaction> t = Transaction.fromJsonList(json.decode(response));
    transactions
      ..clear()
      ..addAll(t)
      ..sort((Transaction t1, Transaction t2) => t2.compare(t1));
  }

  /// Perform payment.
  Future<String> pay(
          String bnf, String amount, String details, String keygap) async =>
      _api.pay(bnf, amount, details, apiKey, keygap);

  /// Get log of a job.
  Future<WtsLog> log(String job) async => _api.output(job, apiKey);

  /// Get job info.
  Future<Job> job(String id) async => _api.job(id, apiKey);

  /// Get title from key.
  String title() => apiKey.split('-')[0];

  /// returns zold balance
  /// can change the suffix by passing it.
  String balance({String suffix = ' ZLD'}) {
    String res = '';
    try {
      res = (_head.balance / pow(2, 32)).toStringAsFixed(2) + suffix;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      res = 'not available';
    }
    return res;
  }

  /// Update the conversion rate.
  Future<void> updateRate() async => rate = await _api.rate();

  /// return value in usd for example $12
  /// to change the prefix and suffix pass them as optional params
  String usd({String prefix = '\$', String suffix = ''}) {
    String res = '';
    try {
      res += prefix;
      res += (double.parse(balance(suffix: '')) * double.parse(rate))
          .toStringAsFixed(2);
      res += suffix;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      res = 'USD not available';
    }
    return res;
  }

  /// return balance in zents
  String zents({String suffix = 'zents'}) => '${_head.balance} $suffix';

  /// dispose the wallet
  void dispose() {
    apiKey = '';
    keygap = '';
    _head = Head.nullHead();
    phone = '';
    _api = API();
    transactions.clear();
    rate = 'rate';
  }
}
