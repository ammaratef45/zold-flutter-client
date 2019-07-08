import 'package:flutter/material.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:zold_wallet/stateless_views/text_field.dart';
import 'package:flutter/services.dart';

typedef StringCallback = void Function(String);

/// PhoneView is the view that propmt for the phone number.
class PhoneView extends StatefulWidget {
  /// constructor
  PhoneView({this.onSendCode, this.authCallback});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// onSendCode callback will execute when send code being clicked.
  final StringCallback onSendCode;

  /// authCallback will execute when pressing login with auth.
  final VoidCallback authCallback;

  final TextEditingController _phoneController = TextEditingController();

  void sendCode() {
    if (_formKey.currentState.validate()) {
      onSendCode(_phoneController.text);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _PhoneView();
  }
}

class _PhoneView extends State<PhoneView> {
  @override
  void initState() {
    super.initState();
    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = await MobileNumber.mobileNumber;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      widget._phoneController.text = mobileNumber;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 18),
            ),
            Image.asset(
              'assets/icon/icon2.png',
              fit: BoxFit.contain,
              height: 84,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18),
            ),
            Text('Login', style: Theme.of(context).textTheme.title),
            const Padding(
              padding: EdgeInsets.only(top: 18),
            ),
            Text('Use your Mobile number to verify your login by SMS code.',
                style: Theme.of(context).textTheme.subtitle),
            const Padding(
              padding: EdgeInsets.only(top: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ZoldTextField(
                    controller: widget._phoneController,
                    hint: 'Mobile Phone',
                    width: 300,
                    prefixIcon: Icons.add,
                    keyboardType: TextInputType.number,
                    isDigitsOnly: true,
                    validateRegex: RegExp(r'^[0-9]{8,14}$'),
                    errorMessage: 'Invalid mobile number',
                    onSubmit: widget.sendCode,
                    inputAction: TextInputAction.send),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 22),
            ),
            MaterialButton(
              color: Theme.of(context).accentColor,
              minWidth: 200,
              height: 40,
              onPressed: widget.sendCode,
              child: const Text('Send'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            InkWell(
              child: Text(
                'Or login with an API token',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: widget.authCallback,
            )
          ],
        ),
      ));
}
