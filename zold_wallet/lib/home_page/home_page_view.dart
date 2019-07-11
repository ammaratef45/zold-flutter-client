import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/home_page/home_page_view_model.dart';
import 'package:zold_wallet/stateless_views/head_wallet_view.dart';
import 'package:zold_wallet/stateless_views/icon_text.dart';
import 'package:zold_wallet/stateless_views/information_view.dart';
import 'package:zold_wallet/stateless_views/transaction_view.dart';

import 'package:flutter/material.dart';
import 'package:zold_wallet/wallet.dart';

/// view of home page
class HomePageView extends HomePageViewModel {
  /**
   * @todo #125 fix the font colours, weight and size.
   */
  @override
  Widget build(BuildContext context) => Scaffold(
        key: snackKey,
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return Container(
                        padding: const EdgeInsets.only(left: 6, top: 6),
                        child: InformationView(
                            balanceZents: Wallet.instance().zents(suffix: ''),
                            balanceText: Wallet.instance().balance(),
                            balanceUSD: Wallet.instance().usd()));
                  case 1:
                    return Container(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 6),
                      child: HeadWalletView(
                        Wallet.instance().head,
                        copyCallback: copyid,
                      ),
                    );
                  case 2:
                    return ListView.builder(
                      padding: const EdgeInsets.only(left: 6, top: 3),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: Wallet.instance().transactions.length,
                      itemBuilder: (BuildContext context, int index) =>
                          TransactionView(
                              Wallet.instance().transactions[index]),
                    );
                  case 3:
                    return Visibility(
                      visible: Wallet.instance().transactions.isEmpty,
                      child: Center(child: Text(message)),
                    );
                }
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/pay');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.send),
                    IconText('Pay'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: refresh,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.file_download),
                    IconText('Pull'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/create');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.receipt),
                    IconText('Invoice'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/settings');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.settings),
                    IconText('Settings'),
                  ],
                ),
              ),
              /*IconButton(icon: const Icon(Icons.delete), onPressed: restart),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: logout,
              ),*/
            ],
          ),
        ),
      );
}
