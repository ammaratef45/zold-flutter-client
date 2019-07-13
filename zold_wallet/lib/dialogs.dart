import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'package:zold_wallet/job.dart';
import 'package:zold_wallet/wallet.dart';
import 'wts_log.dart';

typedef WaitingCallback = Future<String> Function();

/// Enumeration of possible operation actions.
enum DialogResult {
  /// Operation approved.
  ok,

  /// Operation cancelled.
  cancel,

  /// Operation closed.
  close
}

/// Dialog for waiting for jobs.
class WaitingDialog extends StatefulWidget {
  /// Constructor.
  const WaitingDialog(this._id);
  final String _id;
  @override
  State<StatefulWidget> createState() => WaitingDialogView(_id);
}

/// View of waiting dialog.
class WaitingDialogView extends State<WaitingDialog> {
  /// Constructor.
  WaitingDialogView(this._id);
  String _id;
  String _progeessText = 'got: 0 bytes';
  @override
  void initState() {
    super.initState();
    _wait();
  }

  Future<void> _wait() async {
    String status = 'Running';
    while (status == 'Running') {
      try {
        final Job job = await Wallet.instance().job(_id);
        setState(() {
          _progeessText = 'got: ${job.outputLength} bytes';
        });
        // ignore: avoid_catches_without_on_clauses
      } catch (ex) {
        print(ex);
      }
      await Future<void>.delayed(const Duration(milliseconds: 500));
      status = (await Wallet.instance().log(_id)).status;
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Text(_progeessText),
          const CircularProgressIndicator()
        ],
      );
}

/// Dialogs class.
class Dialogs {
  /// waiting dialog for timed operations.
  static Future<String> waitingDialog(BuildContext context,
      WaitingCallback callback, GlobalKey<ScaffoldState> scaffoldKey,
      {bool returnsJobId = true}) async {
    unawaited(showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(
              child: const CircularProgressIndicator(),
            )));
    if (!returnsJobId) {
      final String res = await callback();
      Navigator.of(context).pop(res);
      return res;
    }
    String id = '';
    try {
      id = await callback();
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Navigator.of(context).pop();
      await messageDialog(context, 'Error', e.toString(), scaffoldKey);
      return 'error';
    }
    final WaitingDialog w = WaitingDialog(id);
    Navigator.pop(context);
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('wait'),
              content: SingleChildScrollView(
                child: w,
              ),
            ));

    final WtsLog log = await Wallet.instance().log(id);
    final Job job = await Wallet.instance().job(id);
    String message = 'The operation ended with ${log.status} status\n';
    if (job.status != null &&
        job.status == 'Error' &&
        job.errorMessage != null) {
      message += message + job.errorMessage;
    }
    if (log.status.toLowerCase() == 'ok') {
      return 'ok';
    }
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(log.status == null ? 'null' : log.status),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('Full log'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/log', arguments: log);
                },
              ),
            ],
          ),
    );
    return 'done';
  }

  /// Dilaog for showing messages or asking confirmation.
  static Future<DialogResult> messageDialog(BuildContext context, String title,
          String message, GlobalKey<ScaffoldState> scaffoldKey,
          {bool prompt = false, String promptText = 'OK'}) async =>
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: Text(message),
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop(DialogResult.close);
                  },
                ),
                Visibility(
                  visible: prompt,
                  child: FlatButton(
                    child: Text(promptText),
                    onPressed: () {
                      Navigator.of(context).pop(DialogResult.ok);
                    },
                  ),
                ),
                FlatButton(
                  child: const Text('Copy'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: message));
                    scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: const Text('copied')));
                  },
                ),
              ],
            ),
      );
}
