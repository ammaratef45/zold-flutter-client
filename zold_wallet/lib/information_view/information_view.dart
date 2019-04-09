import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InformationView extends StatelessWidget {
  final String idText;
  final String balanceText;
  final String balanceZents;
  final String balanceUSD;
  const InformationView(
    {
      this.idText="",
      this.balanceText="",
      this.balanceZents="",
      this.balanceUSD=""
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
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(new ClipboardData(text: idText));
                  Scaffold.of(context).showSnackBar(SnackBar
                    (content: Text('ID copied')));
                },
                child: Icon(Icons.content_copy,),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 18),
            child: Row(
              children: <Widget>[
                Text("Balance: "),
                
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar
                      (content: Text(balanceZents)));
                  },
                  child: Text(balanceText + " - " + balanceUSD),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return widget;
  }
  
}