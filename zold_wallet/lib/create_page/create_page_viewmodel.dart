import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/invoice.dart';
import './create_page.dart';
import '../wallet.dart';
import '../wts_log.dart';
import 'package:path_provider/path_provider.dart';


typedef Future<WtsLog> WaitingCallback();
abstract class CreatePageViewModel extends State<CreatePage> {
  Wallet wallet = Wallet.instance();
  final amountController = TextEditingController();
  final messageController = TextEditingController();
  GlobalKey globalKey = new GlobalKey();
  var snackKey = GlobalKey<ScaffoldState>();
  String qrString = "";
  bool created = false;
  bool canCopy = true;
  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  Future<void> createQR() async {
    Invoice invoice;
    try {
      invoice = await wallet.invoice();
    } catch (e) {
      Dialogs.messageDialog(context, 'Error', e.toString(), snackKey);
      return;
    }
    setState(() {
      Map<String, String> values =Map();
      values["bnf"] = invoice.invoice;
      values["amount"] = amountController.text;
      values["details"] = messageController.text;
      qrString = json.encode(values);
      created = true;
    });
  }

  void copyContent() {
    if(canCopy) {
      canCopy = false;
      Clipboard.setData(new ClipboardData(text:  qrString));
      snackKey.currentState.showSnackBar(SnackBar(content: Text('invoice copied')));
      Future.delayed(new Duration(seconds:2)).then((_){
        canCopy = true;
      });
    }
  }

  void captureAndSharePng() async {
    
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);
      final channel = const MethodChannel('channel:ammar.zold.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }
}