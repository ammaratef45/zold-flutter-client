import 'backend/API.dart';
import 'wts_log.dart';

class Wallet {
  String apiKey;
  String keygap;
  String id;
  String balanceZents="pull";
  String phone;
  API api =API();
  Wallet._();
  static final Wallet wallet = Wallet._();
  setPhone(String phone) {
    this.phone =phone;
  }

  Future<Wallet> sendCode() async{
    await api.getCode(phone)
      .catchError((ex){
        throw Exception("Error: " + ex.toString());
      });
      return this;
  }

  bool keyLoaded() {
    return apiKey != null;
  }

  Future<Wallet> getKey(String code) async {
    await api.getToken(phone, code)
      .then((token){
        apiKey =token;
      })
      .catchError((ex){
        throw Exception("Error: " + ex.toString());
      });
      return this;
  }

  Future<Wallet> confirm() async {
    await api.confirm(apiKey, keygap)
      .catchError((ex){
        throw Exception("Error: " + ex.toString());
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
        throw Exception("Error: " + ex.toString());
      });
    return result;
  }

  Future<String> getKeyGap() async {
    await api.keygap(apiKey)
      .then((res){
        keygap = res;
      })
      .catchError((ex){
        throw Exception("Error: " + ex.toString());
      });
    return keygap;
  }

  Future<WtsLog> pull() async {
    WtsLog log;
    await api.pull(apiKey)
    .then((response) async{
      String status = "Running";
      while (status == "Running") {
        status = (await api.output(response, apiKey)).status;
        await Future.delayed(const Duration(seconds: 2)); 
      }
      log = await api.output(response, apiKey);
    })
    .catchError((ex){
      throw ex;
    });
    return log;
  }

  Future<String> getId() async {
    await api.getId(apiKey)
    .then((res){
      id= res;
    })
    .catchError((ex){
      throw Exception("Error: " + ex.toString());
    });
    return id;
  }

  Future<String> getBalanace() async {
    await api.getBalance(apiKey)
    .then((res){
      res=="pull"?balanceZents = "pull":balanceZents = res;
    })
    .catchError((ex){
      throw Exception("Error: " + ex.toString());
    });
    return balanceZents;
  }

  Future<WtsLog> pay(String bnf, String amount, String details, String keygap) async {
    String jobId = await api.pay(bnf, amount, details, apiKey, keygap);
    String status = "Running";
    while (status == "Running") {
      status = (await api.output(jobId, apiKey)).status;
      await Future.delayed(const Duration(seconds: 2)); 
    }
    return api.output(jobId, apiKey);
  }

}