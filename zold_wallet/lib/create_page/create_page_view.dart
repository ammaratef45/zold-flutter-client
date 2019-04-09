import 'package:zold_wallet/create_page/create_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';


class CreatePageView extends CreatePageViewModel {
  Widget copy() {
    return Container(
      child: FloatingActionButton(
        onPressed: copyContent,
        tooltip: 'Copy',
        heroTag: "Copy",
        child: Icon(Icons.content_copy),
      ),
    );
  }

  Widget share() {
    return Container(
      child: FloatingActionButton(
        onPressed: captureAndSharePng,
        tooltip: 'Share',
        heroTag: "Share",
        child: Icon(Icons.share),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
      appBar: AppBar(
        title: Text("Invoice"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text("Amount: "),
                      ),
                      Flexible(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'eg. 1.2'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text("Details: "),
                      ),
                      Flexible(
                        child: TextField(
                          controller: messageController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'eg. for selling me the book'
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: RaisedButton(
                      child: Text("Create"),
                      onPressed: ()=> createQR(),
                    ),
                  ),
                  Visibility(
                    visible: created,
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        version: 6,
                        data: qrString,
                        onError: (ex) {
                          Dialogs.messageDialog(context, "[QR] ERROR",
                           ex.toString(), snackKey);
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: created,
                    child: Text(qrString),
                  )
                  
                ],
              );
          }
        },
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          copy(),
          share(),
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      ),
    );
  }

}