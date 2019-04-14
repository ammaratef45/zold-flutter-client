import 'dart:convert';
import 'dart:math';

import 'package:zold_wallet/invoice.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/transaction.dart';

import 'backend/API.dart';
import 'wts_log.dart';

class Wallet {
  String apiKey="";
  String keygap="";
  String id="";
  String balanceZents="pull";
  String phone="";
  API api =API();
  List<Transaction> transactions = List();

  String rate="rate";
  Wallet._();
  static Wallet _wallet;

  static Wallet instance() {
    if(_wallet == null) {
      _wallet = Wallet._();
    }
    return _wallet;
  }

  void changePhone(String phone) {
    this.phone = phone;
  }

  Future<void> update() async {
    await updateId();
    await updateBalanace();
    await updateTransactions();
    await updateRate();
  }

  Future<String> sendCode() async{
    return await api.getCode(phone);
  }

  bool keyLoaded() {
    return apiKey != null && apiKey != "";
  }

  Future<void> getKey(String code) async {
    apiKey = await api.getToken(phone, code);
  }

  Future<Invoice> invoice() async {
    return await api.invoice(apiKey);
  }

  Future<void> confirm() async {
    await api.confirm(apiKey, keygap);
  }

  Future<bool> confirmed() async {
    return await api.confirmed(apiKey) == "yes";
  }

  Future<String> getKeyGap() async {
    keygap = await api.keygap(apiKey);
    return keygap;
  }

  Future<String> pull() async {
    return await api.pull(apiKey);
  }

  Future<String> restart() async {
    return await api.recreate(apiKey);
  }

  Future<void> updateId() async {
    id = await api.getId(apiKey);
  }

  Future<void> updateBalanace() async {
    balanceZents = await api.getBalance(apiKey);
  }

  Future<void> updateTransactions() async {
    String response = await api.transactions(apiKey);
    List<Transaction> t = Transaction.fromJsonList(json.decode(response));
    transactions.clear();
    transactions.addAll(t);
    transactions.sort((t1, t2) {
      return t2.compare(t1);
    });
  }

  Future<String> pay(String bnf, String amount, String details, String keygap) async {
    return await api.pay(bnf, amount, details, apiKey, keygap);
  }

  Future<WtsLog> log(String job) async {
    return await api.output(job, apiKey);
  }

  Future<Job> job(String id) async {
    return await api.job(id, apiKey);
  }

  String title() {
    return apiKey.split("-")[0];
  }

  String balance({String suffix="ZLD"}) {
    String res = "";
    try {
      res = (double.parse(balanceZents)/pow(2,32)).toStringAsFixed(3) + suffix;
    } catch (e) {
      res = "not available";
    }
    return res;
  }

  Future<void> updateRate() async {
    this.rate = await api.rate();
  }

  String usd({String suffix="USD"}) {
    String res = "";
    try {
      res = (double.parse(this.balance(suffix: "")) * double.parse(rate)).toStringAsFixed(2);
      res += suffix;
    } catch (e) {
      res = "USD not available";
    }
    return res;
  }

  String zents({String suffix="zents"}) {
    if(balanceZents!='pull') {
      return balanceZents + suffix;
    }
    return balanceZents;
  }

}