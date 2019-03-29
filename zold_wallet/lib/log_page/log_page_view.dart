import 'package:flutter/services.dart';
import 'package:zold_wallet/log_page/log_page_viewmodel.dart';
import 'package:zold_wallet/wts_log.dart';

import 'package:flutter/material.dart';



class LogPageView extends LogPageViewModel {
  LogPageView(WtsLog _log){
    log =_log;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
      appBar: AppBar(
        title: Text("Log"),
      ),
      body: SingleChildScrollView(
        child: Text(
          log.fullLog,
          //style: TextStyle(fontFamily: 'MonoSpace'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.content_copy),
              onPressed: () {
                Clipboard.setData(new ClipboardData(text: log.fullLog));
                snackKey.currentState.showSnackBar(SnackBar
                  (content: Text('Log copied')));
              },
            ),
          ],
        ),
      ),
    );
  }

}