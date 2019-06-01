import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZoldTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final double width;
  final IconData prefixIcon;
  final bool isDigitsOnly;

  ZoldTextField(
      {@required this.controller,
      this.keyboardType = TextInputType.text,
      this.hint = '',
      this.width = 240.0,
      this.prefixIcon,
      this.isDigitsOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        

        inputFormatters: <TextInputFormatter>[
          isDigitsOnly
              ? WhitelistingTextInputFormatter.digitsOnly
              : WhitelistingTextInputFormatter(RegExp(r'[\s\S]+'))
        ],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.overline,
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
