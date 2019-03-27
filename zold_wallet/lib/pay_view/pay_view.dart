import 'package:flutter/material.dart';
typedef void PayCallback(String bnf, String amount, String details, String keygap);
class PayView extends StatelessWidget {

  final bnfController;
  final amountController;
  final messageController;
  final keygapController;
  final PayCallback payCallback;

  PayView(
    this.bnfController,
    this.amountController,
    this.messageController,
    this.keygapController,
    this.payCallback
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
                child: Text("Keygap: "),
              ),
              Flexible(
                child: TextField(
                  controller: keygapController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'keygap'
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
          RaisedButton(
            onPressed: (){
              payCallback(bnfController.text, amountController.text, messageController.text, keygapController.text);
              bnfController.clear();
              amountController.clear();
              messageController.clear();
              keygapController.clear();
            },
            child: Text("Send"),
          )
        ],
      ),
    );
    return widget;
  }
  
}