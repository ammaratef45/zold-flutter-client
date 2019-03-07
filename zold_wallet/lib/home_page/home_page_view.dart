import './home_page_view_model.dart';
import 'package:flutter/material.dart';
import '../information_view/information_view.dart';

class HomePageView extends HomePageViewModel {

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
      body: Center(
        child: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: InformatioView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}