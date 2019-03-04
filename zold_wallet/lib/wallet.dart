import 'backend/API.dart';

class Wallet {
  String apiKey;
  String keygap;
  String id;
  String phone;
  API api =API();
  static Wallet loggedInWallet;
  
  Wallet(String phone) {
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

  pull() {
    api.pull(apiKey)
    .then((response){
    })
    .catchError((ex){
    });
  }

  Future<String> getId() async {
    String id;
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
    String balance;
    await api.getBalance(apiKey)
    .then((res){
      balance = res;
    })
    .catchError((ex){
      throw Exception("Error: " + ex.toString());
    });
    return balance;
  }

}