import 'dart:convert';
import 'dart:math';

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

  /// wallet id
  String id = '';

  /// balance of wallet in zents.
  String balanceZents = 'pull';

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
    await updateId();
    await updateBalanace();
    await updateTransactions();
    await updateRate();
  }

  Future<String> sendCode() async {
    return await _api.getCode(phone);
  }

  bool keyLoaded() {
    return apiKey != null && apiKey != '';
  }

  Future<void> getKey(String code) async {
    apiKey = await _api.getToken(phone, code);
  }

  Future<Invoice> invoice() async => _api.invoice(apiKey);

  Future<void> confirm() async {
    await _api.confirm(apiKey, keygap);
  }

  Future<bool> confirmed() async {
    return await _api.confirmed(apiKey) == 'yes';
  }

  Future<String> getKeyGap() async {
    keygap = await _api.keygap(apiKey);
    return keygap;
  }

  Future<String> pull() async {
    return await _api.pull(apiKey);
  }

  Future<String> restart() async {
    return await _api.recreate(apiKey);
  }

  Future<void> updateId() async {
    id = await _api.getId(apiKey);
  }

  Future<void> updateBalanace() async {
    balanceZents = await _api.getBalance(apiKey);
  }

  Future<void> updateTransactions() async {
    String response = await _api.transactions(apiKey);
    List<Transaction> t = Transaction.fromJsonList(json.decode(response));
    transactions.clear();
    transactions.addAll(t);
    transactions.sort((t1, t2) {
      return t2.compare(t1);
    });
  }

  Future<String> pay(
      String bnf, String amount, String details, String keygap) async {
    return await _api.pay(bnf, amount, details, apiKey, keygap);
  }

  Future<WtsLog> log(String job) async {
    return await _api.output(job, apiKey);
  }

  Future<Job> job(String id) async {
    return await _api.job(id, apiKey);
  }

  String title() {
    return apiKey.split('-')[0];
  }

  /// returns zold balance
  /// can change the suffix by passing it.
  String balance({String suffix = ' ZLD'}) {
    String res = '';
    try {
      res =
          (double.parse(balanceZents) / pow(2, 32)).toStringAsFixed(3) + suffix;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      res = 'not available';
    }
    return res;
  }

  Future<void> updateRate() async {
    this.rate = await _api.rate();
  }

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
  String zents({String suffix = 'zents'}) {
    if (balanceZents != 'pull') {
      return balanceZents + suffix;
    }
    return balanceZents;
  }

  /// dispose the wallet
  void dispose() {
    apiKey = '';
    keygap = '';
    id = '';
    balanceZents = 'pull';
    phone = '';
    _api = API();
    transactions.clear();
    rate = 'rate';
  }
}
