import 'package:flutter/material.dart';
import 'package:zold_wallet/pay_page/pay_page_viewmodel.dart';
import 'package:zold_wallet/stateless_views/pay_view.dart';

/// view of the pay page
class PayPageView extends PayPageViewModel {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      key: snackKey,
      appBar: AppBar(
        title: const Text('Pay'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Center(
                child: RaisedButton(
                  child: const Text('Scan from QR'),
                  onPressed: scan
                )
              );
            case 1:
              return PayView(
                payCallback: pay,
                authCallback: fillKeyGap,
                keyGapAvailable: keyGapAvailable,
              );
          }
        },
      )
    );

}