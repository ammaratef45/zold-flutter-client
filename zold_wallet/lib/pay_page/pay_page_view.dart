import 'package:flutter/material.dart';
import 'package:zold_wallet/pay_page/pay_page_viewmodel.dart';
import 'package:zold_wallet/stateless_views/pay_view.dart';

/// view of the pay page
class PayPageView extends PayPageViewModel {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      key: snackKey,
      floatingActionButton: FloatingActionButton(
        onPressed: scan,
        tooltip: 'Scan',
        heroTag: 'Scan',
        child: const Icon(Icons.scanner),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: PayView(
            payCallback: pay,
            authCallback: fillKeyGap,
            keyGapAvailable: keyGapAvailable,
            controllers: controllers,
          ),
        )
      )
    );

}