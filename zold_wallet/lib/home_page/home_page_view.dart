import './home_page_view_model.dart';
import 'package:flutter/material.dart';
import '../information_view/information_view.dart';
import '../pay_view/pay_view.dart';
import '../wts_log.dart';

class HomePageView extends HomePageViewModel {

  @override Future<void> showWaitingDialog(WaitingCallback callback) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );
    WtsLog log = await callback();
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(log.status==null?"null":log.status),
          content: Text("The operation ended with ${log.status} status"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Full log"),
              onPressed: () {
                Navigator.of(context).pop();
                showMessageDialog(log.fullLog + "ss");
              },
            ),
          ],
        );
      },
    );
  }

  @override showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ooh"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zold"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          switch(index) {
            case 0:
              return Container(
                height: 220.0,
                child: InformationView(
                  idText: id,
                  balanceText: balance,
                  onRefreshed: (){
                    refresh();
                  },
                )
              );
            case 1:
              return PayView(
                bnfController,
                amountController,
                messageController,
                keygapController,
                pay
              );
          }
        },
      )
    );
  }

}