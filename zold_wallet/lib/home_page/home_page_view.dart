import 'package:zold_wallet/home_page/home_page_view_model.dart';
import 'package:zold_wallet/information_view/information_view.dart';
import 'package:zold_wallet/transaction_view.dart';

import 'package:flutter/material.dart';



class HomePageView extends HomePageViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              logout();
            },
          )
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icon/icon.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(wallet.title()),
            )
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Container(
                height: 120.0,
                child: InformationView(
                  idText: id,
                  balanceText: balance,
                  balanceZents: balanceZent,
                )
              );
            case 1:
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionView(transactions[index]);
                },
              );
            case 2:
              return Visibility(
                visible: transactions.isEmpty,
                child: Center(
                  child: Text('This wallet is Empty, make some transactions')
                ),
              );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.of(context).pushNamed('/pay');
              },
            ),
            RaisedButton(
              child: Text('Pull'),
              onPressed: () {
                refresh();
              },
            ),
            RaisedButton(
              child: Text('RESTART'),
              onPressed: () {
                restart();
              },
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: () {
                Navigator.of(context).pushNamed('/create');
              },
            ),
          ],
        ),
      ),
    );
  }

}