import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/wallet.dart';
import 'wts_log.dart';

typedef Future<String> WaitingCallback();

class WaitingDialog extends StatefulWidget {
  final String _id;
  final Wallet _wallet;
  WaitingDialog(this._id, this._wallet);
  @override
  State<StatefulWidget> createState() => WaitingDialogView(_id, _wallet);

}

class WaitingDialogView extends State<WaitingDialog> {
  String id;
  String progeessText = "got: 0 bytes";
  Wallet wallet;
  WaitingDialogView(this.id, this.wallet);
  @override
  void initState() {
    super.initState();
    wait();
  }
  void wait() async {
    String status = "Running";
    while (status == "Running") {
      try {
        Job job = await wallet.job(id);
        setState(() {
          progeessText = "got: ${job.outputLength} bytes";
        });
      } catch(ex) {}
      await Future.delayed(const Duration(milliseconds: 500));
      status = (await wallet.log(id)).status;  
    }
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(progeessText),
        CircularProgressIndicator()
      ],
    );
  }

}
class Dialogs {
  static Future<void> waitingDialog
  (
    BuildContext context,
    WaitingCallback callback,
    GlobalKey<ScaffoldState> scaffoldKey,
    Wallet wallet
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );

    String id = await callback();
    WaitingDialog w = WaitingDialog(id, wallet);
    Navigator.pop(context);
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("wait"),
            content: SingleChildScrollView(
              child: w,
            ),
          );
        }
    );

    WtsLog log = await wallet.log(id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(log.status==null?"null":log.status),
          content: Text("The operation ended with ${log.status} status"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Full log"),
              onPressed: () {
                Navigator.of(context).pop();
                messageDialog(context, "Log", log.fullLog, scaffoldKey);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> messageDialog
  (
    BuildContext context,
    String title,
    String message,
    GlobalKey<ScaffoldState> scaffoldKey
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child:Text(message),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Copy"),
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: message));
                  scaffoldKey.currentState.showSnackBar(SnackBar
                    (content: Text('copied')));
              },
            ),
          ],
        );
      },
    );
  }
}