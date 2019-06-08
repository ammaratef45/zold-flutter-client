import 'package:zold_wallet/create_page/create_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';

/// view of invoice page
class CreatePageView extends CreatePageViewModel {
  Widget _copy() => Container(
        child: FloatingActionButton(
          onPressed: copyContent,
          tooltip: 'Copy',
          heroTag: 'Copy',
          child: const Icon(Icons.content_copy),
        ),
      );

  Widget _share() => Container(
        child: FloatingActionButton(
          onPressed: captureAndSharePng,
          tooltip: 'Share',
          heroTag: 'Share',
          child: const Icon(Icons.share),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        key: snackKey,
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Create Invoice'),
                      const SizedBox(
                        height: 10,
                      ),
                      ZoldTextField(
                        controller: amountController,
                        width: 150,
                        hint: 'Amount: eg. 1.2',
                        label: 'Amount',
                      ),
                      ZoldTextField(
                        controller: messageController,
                        width: 310,
                        hint: 'Details: eg. for selling me the book',
                        label: 'Details',
                      ),
                      RaisedButton(
                        child: const Text('Create'),
                        onPressed: createQR,
                      ),
                      Visibility(
                        visible: created,
                        child: RepaintBoundary(
                          key: globalKey,
                          child: QrImage(
                            version: 6,
                            data: qrString,
                            onError: (dynamic ex) {
                              Dialogs.messageDialog(context, '[QR] ERROR',
                                  ex.toString(), snackKey);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: created,
                        child: Text(qrString),
                      ),
                      InkWell(
                        child: Text(
                          'Go back to home screen',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          fabButtons: <Widget>[
            _copy(),
            _share(),
          ],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close,
        ),
      );
}
