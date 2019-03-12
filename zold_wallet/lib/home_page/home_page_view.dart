import './home_page_view_model.dart';
import 'package:flutter/material.dart';
import '../information_view/information_view.dart';
import '../pay_view/pay_view.dart';

class HomePageView extends HomePageViewModel {

  @override void showWaitingDialog(WaitingCallback callback) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(),);
        }
    );
    await callback();
    Navigator.pop(context);
  }

  @override showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Ooh"),
          content: new Text(message),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
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
                    showWaitingDialog(refresh);
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