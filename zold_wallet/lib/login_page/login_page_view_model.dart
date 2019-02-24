import 'package:flutter/material.dart';
import './login_page.dart';
import '../backend/API.dart';
import 'package:country_code_picker/country_code_picker.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  final apiKeyController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final secretCodeController = TextEditingController();
  API api = API();
  String dialCode = "+20";
  String phoneNumber;
  
  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  showErrorDialog() {}
  showCodeDialog() {}

  void loginPhone() {
    getCode();
  }

  void getCode() {
    phoneNumber = dialCode + phoneNumberController.text;
    phoneNumber = phoneNumber.replaceAll("+", "");
    api.getCode(phoneNumber)
    .then(showCodeDialog())
    .catchError((ex){
      showErrorDialog();
    });
  }

  void pickedCode(CountryCode object) {
    dialCode =object.dialCode;
  }

  void getApiKey() {
    api.getToken(phoneNumber, secretCodeController.text)
    .then((token){
      debugPrint(token);
    })
    .catchError((ex){
      showErrorDialog();
    });
  }

  void pullWallet() {
    api.pull(apiKeyController.text)
    .then((response){
      debugPrint(response);
    })
    .catchError((ex){
      debugPrint(ex.toString());
      showErrorDialog();
    });
  }
}