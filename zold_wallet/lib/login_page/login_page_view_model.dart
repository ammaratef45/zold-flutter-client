import 'package:flutter/material.dart';
import './login_page.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  final secretCodeController = TextEditingController();
  String dialCode = "+20";
  Wallet wallet;
  SharedPreferences prefs;
  
  LoginPageViewModel() {
    lazyLogin();
  }

  lazyLogin() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getString('key')?? "0" != "0") {
      // Perform lazy login
    }
  }
  
  @override
  void dispose() {
    phoneNumberController.dispose();
    secretCodeController.dispose();
    super.dispose();
  }

  void showMessageDialog(String message, Function callback) {}

  void loginPhone() async {
    if(!wallet.keyLoaded()) await
      wallet.getKey(secretCodeController.text)
        .then((w) async {
        })
        .catchError((error){
          showMessageDialog(error.toString(), onDialogClosed);
        });
    if(await wallet.isConfirmed()) {
      Wallet.loggedInWallet = wallet;
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      String keygap = await wallet.getKeyGap();
      showMessageDialog("You keygap is: $keygap please save it in a safe place\n"
        + "once you press okay it will be deleted frpm our server", confirmTheKey);
    }
  }

  void confirmTheKey() async {
    await wallet.confirm();
    Wallet.loggedInWallet = wallet;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void getCode() {
    var phoneNumber = dialCode + phoneNumberController.text;
    phoneNumber = phoneNumber.replaceAll("+", "");
    wallet = Wallet(phoneNumber);
    wallet.sendCode()
      .then((w){
        showMessageDialog("we sent a code to " + phoneNumber, onDialogClosed);
      })
      .catchError((error) {
        showMessageDialog(error.toString(), onDialogClosed);
      });
  }

  void pickedCode(CountryCode object) {
    dialCode =object.dialCode;
  }

  void onDialogClosed() {
  }
}