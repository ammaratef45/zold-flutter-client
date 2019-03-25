import 'package:flutter/material.dart';
import 'package:zold_wallet/dialogs.dart';
import './login_page.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginPageViewModel extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  final secretCodeController = TextEditingController();
  String dialCode = "+20";
  Wallet wallet = Wallet.wallet;
  SharedPreferences prefs;
  var snackKey = GlobalKey<ScaffoldState>();
  
  
  LoginPageViewModel() {
    lazyLogin();
  }

  lazyLogin() async {
    prefs = await SharedPreferences.getInstance();
    String key = prefs.getString('key')?? "0";
    debugPrint(key);
    if( key != "0") {
      wallet.apiKey = key;
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
  
  @override
  void dispose() {
    phoneNumberController.dispose();
    secretCodeController.dispose();
    super.dispose();
  }

  void loginPhone() async {
    var phoneNumber = dialCode + phoneNumberController.text;
    phoneNumber = phoneNumber.replaceAll("+", "");
    wallet.setPhone(phoneNumber);
    if(!wallet.keyLoaded()) await
      wallet.getKey(secretCodeController.text)
        .then((w) async {
        })
        .catchError((error){
          Dialogs.messageDialog(context, "error", error.toString(), snackKey);
        });
    if(await wallet.isConfirmed()) {
      await prefs.setString('key', wallet.apiKey);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      String keygap = await wallet.getKeyGap();
      await Dialogs.messageDialog(context, "Confirm", "You keygap is: $keygap please save it in a safe place\n"
        + "once you press okay it will be deleted from WTS server", snackKey);
      confirmTheKey();
    }
  }

  void confirmTheKey() async {
    await wallet.confirm();
    await prefs.setString('key', wallet.apiKey);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void getCode() {
    var phoneNumber = dialCode + phoneNumberController.text;
    phoneNumber = phoneNumber.replaceAll("+", "");
    wallet.setPhone(phoneNumber);
    wallet.sendCode()
      .then((w){
        Dialogs.messageDialog(context, "Alert", "we sent a code to " + phoneNumber, snackKey);
      })
      .catchError((error) {
        Dialogs.messageDialog(context, "Error", error.toString(), snackKey);
      });
  }

  void pickedCode(CountryCode object) {
    dialCode =object.dialCode;
  }
}