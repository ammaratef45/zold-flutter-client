import 'package:flutter/material.dart';
import './pay_page.dart';
import '../wallet.dart';
import '../wts_log.dart';
import '../payment.dart';
import 'package:zold_wallet/dialogs.dart';

typedef Future<WtsLog> WaitingCallback();
abstract class PayPageViewModel extends State<PayPage> {
  Wallet wallet = Wallet.wallet;
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();
  var snackKey = GlobalKey<ScaffoldState>();

  PayPageViewModel();


  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  // @todo #18 add ability to scan details from QR.
  void pay(String bnf, String amount, String details, String keygap) async {
    Payment payment =Payment(bnf, amount, details, keygap);
    await Dialogs.waitingDialog(context, payment.doPay, snackKey);
  }
}