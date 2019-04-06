import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  String qrString = "";
  bool created = false;
  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    messageController.dispose();
  }

  Future<void> createQR() async {
    Invoice invoice = await wallet.invoice();
    setState(() {
      Map<String, String> values =Map();
      values["bnf"] = invoice.invoice;
      values["amount"] = amountController.text;
      values["details"] = messageController.text;
      qrString = json.encode(values);
      created = true;
    });
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