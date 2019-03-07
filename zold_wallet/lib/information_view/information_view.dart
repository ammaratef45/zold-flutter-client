import 'package:flutter/material.dart';

class InformationView extends StatelessWidget {
  final String idText;
  final String balanceText;
  final VoidCallback onRefreshed;
  const InformationView(
    {
      this.idText="",
      this.balanceText="",
      @required this.onRefreshed
    }
  );
  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("ID: "),
              Flexible(
                child: Text(idText),
              )
            ],
          ),
          Container(
            child: Row(
              children: <Widget>[
                Text("Balance: "),
                Flexible(
                  child: Text(balanceText),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: onRefreshed,
            child: Text("Refresh"),
          )
        ],
      ),
    );
    return widget;
  }
  
}