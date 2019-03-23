import './home_page_view_model.dart';
import 'package:flutter/material.dart';
import '../information_view/information_view.dart';



class HomePageView extends HomePageViewModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: snackKey,
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
              // @todo #27 sort desc, add more info and show better design
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(transactions[index].details);
                },
              );
          }
        },
      ),
    );
  }

}