import 'package:flutter/material.dart';
import 'package:zold_wallet/pay_page/pay_page_viewmodel.dart';
import 'package:zold_wallet/pay_view/pay_view.dart';


class PayPageView extends PayPageViewModel {

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
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Center(
                child: RaisedButton(
                  child: Text("Scan from QR"),
                  onPressed: scan
                )
              );
            case 1:
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