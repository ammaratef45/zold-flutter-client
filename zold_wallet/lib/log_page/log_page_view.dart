import 'package:flutter/services.dart';
import 'package:zold_wallet/log_page/log_page_viewmodel.dart';
import 'package:zold_wallet/wts_log.dart';

import 'package:flutter/material.dart';

/// View of logpage
class LogPageView extends LogPageViewModel {
  /// ctor
  LogPageView(WtsLog _log) {
    log = _log;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: snackKey,
        appBar: AppBar(
          title: const Text('Log'),
        ),
        body: SingleChildScrollView(
          child: Text(
            log.fullLog,
            //style: TextStyle(fontFamily: 'MonoSpace'),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: log.fullLog));
                  snackKey.currentState.showSnackBar(
                      SnackBar(content: const Text('Log copied')));
                },
              ),
            ],
          ),
        ),
      );
}
