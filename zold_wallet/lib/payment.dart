import 'wallet.dart';

/// Payment model and behaviour.
class Payment {
  /// ctor
  Payment(this.bnf, this.amount, this.details, this.keygap);

  /// bnf of the payment
  String bnf;

  /// amount of payment
  String amount;

  /// details of payment
  String details;

  /// keygap of wallet
  String keygap;

  /// do the payment process
  Future<String> doPay() async =>
      Wallet.instance().pay(bnf, amount, details, keygap);
}
