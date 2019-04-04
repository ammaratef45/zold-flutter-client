import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/wallet.dart';
import 'wts_log.dart';

typedef Future<String> WaitingCallback();

enum DialogResult {
  OK,
  CANCEL,
  CLOSE
}

class WaitingDialog extends StatefulWidget {
  final String _id;
  WaitingDialog(this._id);
  @override
  State<StatefulWidget> createState() => WaitingDialogView(_id);

}

class WaitingDialogView extends State<WaitingDialog> {
  String id;
  String progeessText = "got: 0 bytes";
  WaitingDialogView(this.id);
  @override
  void initState() {
    super.initState();
    wait();
  }
  void wait() async {
    String status = "Running";
    while (status == "Running") {
      try {
        Job job = await Wallet.instance().job(id);
        setState(() {
          progeessText = "got: ${job.outputLength} bytes";
        });
      } catch(ex) {}
      await Future.delayed(const Duration(milliseconds: 500));
      status = (await Wallet.instance().log(id)).status;  
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
    {bool returnsJobId = true}
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );
    if(!returnsJobId) {
      Navigator.of(context).pop(await callback());
      return;
    }
    String id = "";
    try {
      id = await callback();
    } catch (e) {
      Navigator.of(context).pop();
      messageDialog(context, 'Error', e.toString(), scaffoldKey);
      return;
    }
    WaitingDialog w = WaitingDialog(id);
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

    WtsLog log = await Wallet.instance().log(id);
    Job job = await Wallet.instance().job(id);
    String message = "The operation ended with ${log.status} status\n";
    if(job.status!=null && job.status=='Error' && job.errorMessage!=null) {
      message += message + job.errorMessage;
    }
    if(log.status.toLowerCase() == "ok") {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(log.status==null?"null":log.status),
          content: Text(message),
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
                Navigator.of(context).pushNamed('/log', arguments: log);
              },
            ),
          ],
        );
      },
    );
  }

  static Future<DialogResult> messageDialog
  (
    BuildContext context,
    String title,
    String message,
    GlobalKey<ScaffoldState> scaffoldKey,
    {bool prompt=false}
  ) async {
    return await showDialog(
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
                Navigator.of(context).pop(DialogResult.CLOSE);
              },
            ),
            Visibility(
              visible: prompt,
              child: FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(DialogResult.OK);
                },
              ),
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