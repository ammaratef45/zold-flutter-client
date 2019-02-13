import 'package:flutter/material.dart';
import './home_page.dart';
import './backend/API.dart';

abstract class HomePageViewModel extends State<HomePage> {
  String text = "ID";
  final apiKeyController = TextEditingController();
  API api = API();

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  void getId() {
    api.getId(apiKeyController.text)
    .then((id){
      setState(() {
        text = id;
      });
    })
    .catchError((ex){
      setState(() {
        text = "ID: error";
      });
    });
  }
}