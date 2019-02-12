import './home_page_view_model.dart';
import 'package:flutter/material.dart';

class HomePageView extends HomePageViewModel {

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
              Text(text),
              RaisedButton(
                onPressed: (){
                  setState(() {
                    text = "Hello world";
                  });
                },
                child: Text("btn"),
              )
            ],
          )
        ),
      ),
    );
  }

}