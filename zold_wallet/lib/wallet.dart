import 'dart:math';

import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/transaction.dart';

import 'backend/API.dart';
import 'wts_log.dart';

class Wallet {
  String apiKey;
  String keygap;
  String id;
  String balanceZents="pull";
  String phone;
  API api =API();
  List<Transaction> transactions = List();
  Wallet._();
  static Wallet _wallet;

  static Wallet instance() {
    if(_wallet == null) {
      _wallet = Wallet._();
    }
    return _wallet;
  }

  setPhone(String phone) {
    this.phone =phone;
  }

  Future<Wallet> sendCode() async{
    await api.getCode(phone)
      .catchError((ex){
        throw ex;
      });
      return this;
  }

  bool keyLoaded() {
    return apiKey != null && apiKey != "";
  }

  Future<Wallet> getKey(String code) async {
    await api.getToken(phone, code)
      .then((token){
        apiKey =token;
      })
      .catchError((ex){
        throw ex;
      });
      return this;
  }

  Future<Wallet> confirm() async {
    await api.confirm(apiKey, keygap)
      .catchError((ex){
        throw ex;
      });
      return this;
  }

  Future<bool> isConfirmed() async {
    bool result = false;
    await api.confirmed(apiKey)
      .then((res){
        result =  res=="yes";
      })
      .catchError((ex){
        throw ex;
      });
    return result;
  }

  Future<String> getKeyGap() async {
    await api.keygap(apiKey)
      .then((res){
        keygap = res;
      })
      .catchError((ex){
        throw ex;
      });
    return keygap;
  }

  Future<String> pull() async {
    return await api.pull(apiKey);
  }

  Future<String> restart() async {
    return await api.recreate(apiKey);
  }

  Future<String> getId() async {
    await api.getId(apiKey)
    .then((res){
      id= res;
    })
    .catchError((ex){
      throw ex;
    });
    return id;
  }

  Future<String> getBalanace() async {
    await api.getBalance(apiKey)
    .then((res){
      res=="pull"?balanceZents = "pull":balanceZents = res;
    })
    .catchError((ex){
      throw ex;
    });
    return balanceZents;
  }

  Future<void> getTransactions() async {
    List<Transaction> t = await api.transactions(apiKey);
    transactions.clear();
    transactions.addAll(t);
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

  String balance() {
    return (double.parse(balanceZents)/pow(2,32)).toStringAsFixed(3);
  }

}