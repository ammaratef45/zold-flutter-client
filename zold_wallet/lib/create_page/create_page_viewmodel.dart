import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zold_wallet/create_page/create_page.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/invoice.dart';
import 'package:zold_wallet/wallet.dart';
import 'package:zold_wallet/wts_log.dart';

typedef WaitingCallback = Future<WtsLog> Function();

/// View model of invoice page.
abstract class CreatePageViewModel extends State<CreatePage> {
  /// Controller of amount field.
  final TextEditingController amountController = TextEditingController();

  /// Controller of message key field.
  final TextEditingController messageController = TextEditingController();

  /// Global key.
  GlobalKey globalKey = GlobalKey();

  /// Key for showing snack
  GlobalKey snackKey = GlobalKey<ScaffoldState>();

  /// String of the QR.
  String qrString = '';

  /// is it created or not yet.
  bool created = false;

  /// flag to delay copying the string.
  bool canCopy = true;
  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  /// create QR.
  Future<void> createQR() async {
    Invoice invoice;
    try {
      invoice = await Wallet.instance().invoice();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      await Dialogs.messageDialog(context, 'Error', e.toString(), snackKey);
      return;
    }
    setState(() {
      final Map<String, String> values = <String, String>{};
      values['bnf'] = invoice.invoice;
      values['amount'] = amountController.text;
      values['details'] = messageController.text;
      qrString = json.encode(values);
      created = true;
    });
  }

  /// Copy the content of QR to clipboard.
  void copyContent() {
    if (canCopy) {
      canCopy = false;
      Clipboard.setData(ClipboardData(text: qrString));
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: const Text('invoice copied')));
      Future<void>.delayed(Duration(seconds: 2)).then((_) {
        canCopy = true;
      });
    }
  }

  /// Get the image of QR code and share it.
  Future<void> captureAndSharePng() async {
    try {
      final RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      final ui.Image image = await boundary.toImage();
      final ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final File file = await File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      const MethodChannel channel =
          MethodChannel('channel:ammar.zold.share/share');
      await channel.invokeMethod<void>('shareFile', 'image.png');
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print(e.toString());
    }
  }
}
