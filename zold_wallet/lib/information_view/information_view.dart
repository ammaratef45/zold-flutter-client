import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import './information_viewmodel.dart';

class InformatioView extends InformationViewModel {
  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text("ID: "),
                ),
                Flexible(
                  child: Text(idText),
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
                  child: Text(balanceText),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: refresh,
            child: Text("Refresh"),
          )
        ],
      ),
    );
    return widget;
  }
  
}