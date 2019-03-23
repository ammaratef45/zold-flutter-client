import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'wts_log.dart';

typedef Future<WtsLog> WaitingCallback();
class Dialogs {
  static Future<void> waitingDialog
  (
    BuildContext context,
    WaitingCallback callback,
    GlobalKey<ScaffoldState> scaffoldKey
  ) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );
    /*
     * @todo #26 get job id not a log from the callback.
     *  make the waiting loop here and get job file to show.
     */
     
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