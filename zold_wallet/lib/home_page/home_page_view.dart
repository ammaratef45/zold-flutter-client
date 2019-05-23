import 'package:zold_wallet/home_page/home_page_view_model.dart';
import 'package:zold_wallet/stateless_views/information_view.dart';
import 'package:zold_wallet/stateless_views/transaction_view.dart';

import 'package:flutter/material.dart';
import 'package:zold_wallet/wallet.dart';


/// view of home page
class HomePageView extends HomePageViewModel {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      key: snackKey,
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SafeArea(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              switch(index) {
                case 0:
                  return Container(
                    padding: const EdgeInsets.only(left: 6, top: 6),
                    alignment: const Alignment(-1, 0),
                    child: Image.asset(
                      'assets/icon/icon.png',
                      fit: BoxFit.contain,
                      height: 64,
                    ),
                  );
                case 1:
                  return Container(
                    padding: const EdgeInsets.only(left: 6, top: 6),
                    child: InformationView(
                      idText: Wallet.instance().id,
                      balanceText: Wallet.instance().balance(),
                      balanceZents: Wallet.instance().zents(),
                      balanceUSD: Wallet.instance().usd(),
                      copyCallback: copyid
                    )
                  );
                case 2:
                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 6, top: 3),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: Wallet.instance().transactions.length,
                    itemBuilder: (BuildContext context, int index) =>
                      TransactionView(Wallet.instance().transactions[index]),
                  );
                case 3:
                  return Visibility(
                    visible: Wallet.instance().transactions.isEmpty,
                    child: Center(
                      child: Text(message)
                    ),
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
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                Navigator.of(context).pushNamed('/pay');
              },
            ),
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: refresh,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: restart
            ),
            IconButton(
              icon: const Icon(Icons.receipt),
              onPressed: () {
                Navigator.of(context).pushNamed('/create');
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: logout,
            ),
          ],
        ),
      ),
    );

}