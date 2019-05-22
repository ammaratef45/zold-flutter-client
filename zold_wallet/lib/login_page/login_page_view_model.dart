import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zold_wallet/dialogs.dart';
import 'package:zold_wallet/login_page/login_page.dart';
import 'package:zold_wallet/wallet.dart';

/// pages enumerations
enum CurrentVisiblePage {
  /// page that prompts phone
  phonePage,
  /// page that prompts auth token
  authPage,
  /// page that prompts code
  codePage
}
/// view of login page
abstract class LoginPageViewModel extends State<LoginPage> {
  /// constructor
  LoginPageViewModel() {
    _lazyLogin();
  }
  /// controller of phone number
  final TextEditingController phoneNumberController = TextEditingController();
  /// controller of secret code
  final TextEditingController secretCodeController = TextEditingController();
  /// controller of apikey
  final TextEditingController apiKeyController = TextEditingController();
  FlutterSecureStorage _prefs;
  /// key for using in the snack bar
  GlobalKey snackKey = GlobalKey<ScaffoldState>();
  /// the visible page currently
  CurrentVisiblePage page = CurrentVisiblePage.phonePage;

  Future<void> _lazyLogin() async {
    _prefs = FlutterSecureStorage();
    final String key = await _prefs.read(key: 'key')?? '0';
    if( key != '0') {
      Wallet.instance().apiKey = key;
      await Navigator.of(context).pushReplacementNamed('/home');
    }
  }
  
  @override
  void dispose() {
    phoneNumberController.dispose();
    secretCodeController.dispose();
    apiKeyController.dispose();
    super.dispose();
  }

  /// login with phone
  Future<void> loginPhone(String code) async {
    try {
      await Wallet.instance().getKey(code);
    // ignore: avoid_catches_without_on_clauses
    } catch(e) {
      await Dialogs.messageDialog(context, 'Error', e.toString(), snackKey);
    }
    await login();
  }

  /// login using key
  Future<void> loginWithKey(String apiKey) async {
    Wallet.instance().apiKey = apiKey;
    await login();
  }

  /// perform the login
  Future<void> login() async {
    if(!Wallet.instance().keyLoaded()) {
      throw Exception('apikey is unknown');
    }
    if(await Wallet.instance().confirmed()) {
      await _prefs.write(key: 'key', value: Wallet.instance().apiKey);
      await Navigator.of(context).pushReplacementNamed('/home');
    } else {
      final String keygap = await Wallet.instance().getKeyGap();
      DialogResult res = await Dialogs.messageDialog(
        context, 
        'Confirm',
        'You keygap is: $keygap please save it in a safe place\n'
        'once you press okay it will be deleted from WTS server',
        snackKey,
        prompt: true
      );
      if(res==DialogResult.OK) {
        await confirmTheKey();
      }
    }
  }

  /// confirm the key so it can be destroyed from WTS
  Future<void> confirmTheKey() async {
    await Wallet.instance().confirm();
    await _prefs.write(key: 'key', value: Wallet.instance().apiKey);
    await Navigator.of(context).pushReplacementNamed('/home');
  }

  Future<void> getCode(String phoneNumber) async {
    Wallet.instance().changePhone(phoneNumber);
    try {
      await Dialogs.waitingDialog(
        context,
        Wallet.instance().sendCode,
        snackKey,
        returnsJobId: false
      );
      setState(() {
        page = CurrentVisiblePage.codePage;
      });
    // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      Navigator.of(context).pop();
      await Dialogs.messageDialog(context, 'Error', e.toString(), snackKey);
    }
  }
}