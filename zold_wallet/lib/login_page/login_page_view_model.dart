import 'package:flutter/material.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zold_wallet/login_page/login_page.dart';
import 'package:zold_wallet/wallet.dart';

enum CurrentVisiblePage {
  phonePage,
  authPage,
  codePage
}

abstract class LoginPageViewModel extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  final secretCodeController = TextEditingController();
  final apiKeyController = TextEditingController();
  Wallet wallet = Wallet.instance();
  SharedPreferences prefs;
  var snackKey = GlobalKey<ScaffoldState>();
  CurrentVisiblePage page = CurrentVisiblePage.phonePage;

  
  
  LoginPageViewModel() {
    lazyLogin();
  }

  lazyLogin() async {
    prefs = await SharedPreferences.getInstance();
    String key = prefs.getString('key')?? "0";
    if( key != "0") {
      wallet.apiKey = key;
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
  
  @override
  void dispose() {
    phoneNumberController.dispose();
    secretCodeController.dispose();
    apiKeyController.dispose();
    super.dispose();
  }

  void loginPhone(String code) async {
    try {
      await wallet.getKey(code);
    } catch(e) {
      Dialogs.messageDialog(context, "Error", e.toString(), snackKey);
    }
    login();
  }

  void loginWithKey(String apiKey) async {
    wallet.apiKey = apiKey;
    login();
  }

  void login() async {
    if(!wallet.keyLoaded()) {
      throw Exception("apikey is unknown");
    }
    if(await wallet.confirmed()) {
      await prefs.setString('key', wallet.apiKey);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      String keygap = await wallet.getKeyGap();
      DialogResult res = await Dialogs.messageDialog(context, "Confirm", "You keygap is: $keygap please save it in a safe place\n"
        + "once you press okay it will be deleted from WTS server", snackKey, prompt: true);
      if(res==DialogResult.OK) {
        confirmTheKey();
      }
    }
  }

  void confirmTheKey() async {
    await wallet.confirm();
    await prefs.setString('key', wallet.apiKey);
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void getCode(String phoneNumber) async {
    wallet.changePhone(phoneNumber);
    try {
      await Dialogs.waitingDialog(context, wallet.sendCode, snackKey, returnsJobId: false);
      setState(() {
        page = CurrentVisiblePage.codePage;
      });
    } catch (e) {
      Navigator.of(context).pop();
      Dialogs.messageDialog(context, "Error", e.toString(), snackKey);
    }
  }
}