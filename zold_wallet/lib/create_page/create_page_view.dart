import 'package:zold_wallet/create_page/create_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
import 'package:zold_wallet/stateless_views/title_text.dart';

/// view of invoice page
class CreatePageView extends CreatePageViewModel {
  static const double _gapsHeight = 50;
  static const double _smallGapsHeight = 15;
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const TitleText('Invoice'),
                      const SizedBox(
                        height: _gapsHeight,
                      ),
                      ZoldTextField(
                        controller: amountController,
                        width: 310,
                        hint: 'Amount in zold',
                      ),
                      const SizedBox(
                        height: _gapsHeight,
                      ),
                      ZoldTextField(
                        controller: messageController,
                        width: 310,
                        hint: 'Details',
                      ),
                      const SizedBox(
                        height: _gapsHeight,
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
                      const SizedBox(
                        height: _smallGapsHeight,
                      ),
                      InkWell(
                        child: const Text(
                          'Go back to home screen',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              default:
                return null;
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
