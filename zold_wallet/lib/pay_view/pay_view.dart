import 'package:flutter/material.dart';
import './pay_viewmodel.dart';

class PayView extends PayViewModel {
  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text("data"),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text("bnf: "),
                ),
                Flexible(
                  child: Text("ammaratef45"),
                )
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text("Balance: "),
                ),
                Flexible(
                  child: Text("6K zld"),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: pay,
            child: Text("Send"),
          )
        ],
      ),
    );
    return widget;
  }
  
}