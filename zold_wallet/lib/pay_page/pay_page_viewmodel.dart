import 'package:flutter/material.dart';
import './pay_page.dart';
import '../wallet.dart';
import '../wts_log.dart';
import '../payment.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


typedef Future<WtsLog> WaitingCallback();
abstract class PayPageViewModel extends State<PayPage> {
  Wallet wallet = Wallet.wallet;
  final bnfController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  final keygapController = TextEditingController();
  var snackKey = GlobalKey<ScaffoldState>();
  String scanResult="";

  PayPageViewModel();


  @override
  void dispose() {
    super.dispose();
    bnfController.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  void pay(String bnf, String amount, String details, String keygap) async {
    Payment payment =Payment(bnf, amount, details, keygap);
    await Dialogs.waitingDialog(context, payment.doPay, snackKey, wallet);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      Map<String, dynamic> map = json.decode(barcode);
      setState(() {
        bnfController.text = map["bnf"];
        amountController.text = map["amount"];
        messageController.text = map["details"];
        this.scanResult = "scanned successfully";
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.scanResult = 'You did not grant the camera permission!';
        });
      } else {
        setState(() => this.scanResult = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.scanResult = 'Scan cancelled');
    } catch (e) {
      setState(() => this.scanResult = 'Unknown error: $e');
    }
    Dialogs.messageDialog(context, "Scan", scanResult, snackKey);
  }
}