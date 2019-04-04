import 'package:flutter/material.dart';
import 'package:zold_wallet/wallet.dart';
typedef void PayCallback(String bnf, String amount, String details, String keygap);
class PayView extends StatelessWidget {

  final bnfController;
  final amountController;
  final messageController;
  final keygapController;
  final PayCallback payCallback;
  final VoidCallback authCallback;

  PayView(
    this.bnfController,
    this.amountController,
    this.messageController,
    this.keygapController,
    this.payCallback,
    this.authCallback
  );

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: Text("bnf: "),
              ),
              Flexible(
                child: TextField(
                  controller: bnfController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'eg. ammaratef45'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Text("Amount: "),
              ),
              Flexible(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal:true),
                  decoration: InputDecoration(
                    hintText: 'eg. 1.2'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Balance: ",
                style: TextStyle(
                  color: Colors.red
                ),
              ),
              Text(
                Wallet.instance().balance(),
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Text("Keygap: "),
              ),
              Flexible(
                child: TextField(
                  controller: keygapController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'keygap'
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.fingerprint),
                onPressed: authCallback,
              )
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  payCallback(bnfController.text, amountController.text, messageController.text, keygapController.text);
                },
                child: Text("Send"),
              ),
              RaisedButton(
                onPressed: (){
                  bnfController.clear();
                  amountController.clear();
                  messageController.clear();
                  keygapController.clear();
                },
                child: Text("Clear"),
              ),
            ],
          )
        ],
      ),
    );
    return widget;
  }
  
}