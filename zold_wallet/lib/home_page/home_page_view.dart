import './home_page_view_model.dart';
import 'package:flutter/material.dart';
import '../information_view/information_view.dart';
import '../pay_view/pay_view.dart';
import '../wts_log.dart';

class HomePageView extends HomePageViewModel {

  @override Future<void> showWaitingDialog(WaitingCallback callback) async {
    showDialog(
        context: context,
        barrierDismissible: false,
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
                showMessageDialog(log.fullLog);
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
          content: SingleChildScrollView(
            child:Text(message),
          ),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Request payment'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/create');
              },
            ),
            ListTile(
              title: Text('Pay'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/pay');
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                Navigator.pop(context);
                //signOut();
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        shrinkWrap: true,
        itemCount: 1,
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
          }
        },
      ),
    );
  }

}