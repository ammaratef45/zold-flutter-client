import './pay_page_viewmodel.dart';
import 'package:flutter/material.dart';
import '../pay_view/pay_view.dart';
import '../wts_log.dart';
import 'package:flutter/services.dart';


class PayPageView extends PayPageViewModel {

  @override Future<void> showWaitingDialog(WaitingCallback callback) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );
    WtsLog log = await callback();
    Navigator.pop(context);
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
                showMessageDialog(log.fullLog);
              },
            ),
          ],
        );
      },
    );
  }

  @override showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ooh"),
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
                  snackKey.currentState.showSnackBar(SnackBar
                    (content: Text('copied')));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
      appBar: AppBar(
        title: Text("Pay"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return PayView(
                bnfController,
                amountController,
                messageController,
                keygapController,
                pay
              );
          }
        },
      )
    );
  }

}