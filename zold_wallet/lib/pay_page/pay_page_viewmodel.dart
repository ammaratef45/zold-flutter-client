import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:zold_wallet/pay_page/pay_page.dart';
import 'package:zold_wallet/payment.dart';
import 'package:zold_wallet/wallet.dart';
import 'package:zold_wallet/wts_log.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

typedef WaitingCallback = Future<WtsLog> Function();

/// viewmodel of the pay page
abstract class PayPageViewModel extends State<PayPage> {
  /// constructor
  PayPageViewModel() {
    _checkKeyGap();
  }

  /// controllers of text editors
  final Map<String, TextEditingController> controllers =
      <String, TextEditingController>{
    'bnfController': TextEditingController(),
    'amountController': TextEditingController(),
    'messageController': TextEditingController(),
    'keygapController': TextEditingController(),
  };

  /// global key fo using in snack showing
  GlobalKey snackKey = GlobalKey<ScaffoldState>();

  String _scanResult = '';

  /// chack if jeygap is available
  bool keyGapAvailable = false;

  @override
  void dispose() {
    super.dispose();
    controllers['bnfController'].dispose();
    controllers['amountController'].dispose();
    controllers['messageController'].dispose();
  }

  void _checkKeyGap() {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    storage.read(key: 'keygap').then((String keygap) {
      keygap = keygap ?? '0';
      if (keygap == '0') {
      } else {
        setState(() {
          keyGapAvailable = true;
        });
      }
    });
  }

  /// fill keygap from saved value
  Future<void> fillKeyGap() async {
    if (await authenticate()) {
      final FlutterSecureStorage prefs = FlutterSecureStorage();
      final String keygap = await prefs.read(key: 'keygap') ?? '0';
      if (keygap == '0') {
        await Dialogs.messageDialog(
            context,
            'error',
            'Keygap not found\nenter it and we will save it for next time',
            snackKey);
      } else {
        controllers['keygapController'].text = keygap;
      }
    }
  }

  /// authenticate user locally
  Future<bool> authenticate() async {
    bool result = false;
    try {
      final LocalAuthentication localAuth = LocalAuthentication();
      final bool didAuthenticate = await localAuth.authenticateWithBiometrics(
          localizedReason: 'Please authenticate yourself');
      if (didAuthenticate) {
        result = true;
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        await Dialogs.messageDialog(context, 'error',
            "local auth isn't available in your device", snackKey);
      }
    }
    return result;
  }

  /// make payment
  Future<void> pay(
      String bnf, String amount, String details, String keygap) async {
    final String message = 'You are going to send $amount ZLD '
        'to $bnf. This operation is not refundable! Are you sure?';
    final DialogResult res = await Dialogs.messageDialog(
        context, 'confirm', message, snackKey,
        prompt: true);
    if (res != DialogResult.ok) {
      return;
    }
    if (keygap != null && keygap != '') {
      final FlutterSecureStorage prefs = FlutterSecureStorage();
      await prefs.write(key: 'keygap', value: keygap);
    }
    final Payment payment = Payment(bnf, amount, details, keygap);
    await Dialogs.waitingDialog(context, payment.doPay, snackKey);
    await Wallet.instance().update();
  }

  /// scan from QR
  Future<void> scan() async {
    try {
      final String barcode = await BarcodeScanner.scan();
      final Map<String, dynamic> map = json.decode(barcode);
      setState(() {
        controllers['bnfController'].text = map['bnf'];
        controllers['amountController'].text = map['amount'];
        controllers['messageController'].text = map['details'];
        _scanResult = 'scanned successfully';
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _scanResult = 'You did not grant the camera permission!';
        });
      } else {
        setState(() => _scanResult = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => _scanResult = 'Scan cancelled');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      setState(() => _scanResult = 'Unknown error: $e');
    }
    await Dialogs.messageDialog(context, 'Scan', _scanResult, snackKey);
  }
}
