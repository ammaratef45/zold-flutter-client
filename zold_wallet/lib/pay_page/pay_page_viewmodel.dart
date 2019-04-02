import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:zold_wallet/pay_page/pay_page.dart';
import 'package:zold_wallet/payment.dart';
import 'package:zold_wallet/wallet.dart';
import 'dart:convert';

import 'package:zold_wallet/wts_log.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';


typedef Future<WtsLog> WaitingCallback();
abstract class PayPageViewModel extends State<PayPage> {
  Wallet wallet = Wallet.instance();
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

  void fillKeyGap() async {
    if(await authenticate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String keygap = prefs.getString('keygap')??'0';
      if(keygap=='0') {
        Dialogs.messageDialog(context, 'error',
        'Keygap not found\nenter it and we will save it for next time',
        snackKey, false);
      } else {
        keygapController.text = keygap;
      }
    }
  }

  Future<bool> authenticate() async {
    bool result = false;
    try {
        var localAuth = new LocalAuthentication();

        bool didAuthenticate = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate yourself');
        if(didAuthenticate) {
          result = true;
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notAvailable) {
          await Dialogs.messageDialog(context, 'error',
           "local auth isn't available in your device", snackKey, false);
        }
      }
      return result;
  }

  void pay(String bnf, String amount, String details, String keygap) async {
    if(keygap!=null && keygap!='') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('keygap', keygap);
    }
    Payment payment =Payment(bnf, amount, details, keygap);
    await Dialogs.waitingDialog(context, payment.doPay, snackKey);
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
    Dialogs.messageDialog(context, "Scan", scanResult, snackKey, false);
  }
}