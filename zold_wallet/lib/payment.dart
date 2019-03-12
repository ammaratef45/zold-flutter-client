import 'wallet.dart';
import 'wts_log.dart';

class Payment {
  String bnf;
  String amount;
  String details;
  String keygap;
  Payment(this.bnf, this.amount, this.details, this.keygap);

  Future<WtsLog> doPay() async {
    return Wallet.wallet.pay(bnf, amount, details, keygap);
  }
}