import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// widget for text boxes
class ZoldTextField extends StatelessWidget {
  /// textfield controller
  final TextEditingController controller;

  /// keyboard type
  final TextInputType keyboardType;

  /// label and hint
  final String hint;
  final double width;
  final IconData prefixIcon;
  final bool isDigitsOnly;
  final String errorMessage;
  final RegExp validateRegex;
  final Function onSubmit;
  final TextInputAction inputAction;

  ZoldTextField(
      {@required this.controller,
      this.keyboardType = TextInputType.text,
      this.hint = '',
      this.width = 240.0,
      this.prefixIcon,
      this.isDigitsOnly = false,
      this.errorMessage,
      this.validateRegex,
      this.onSubmit,
      this.inputAction = TextInputAction.done});

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: inputAction,
          onFieldSubmitted: (String value) => onSubmit,
          validator: (String value) {
            if (validateRegex != null &&
                (value.isEmpty || !validateRegex.hasMatch(value))) {
              return errorMessage;
            }
          },
          inputFormatters: <TextInputFormatter>[
            isDigitsOnly
                ? WhitelistingTextInputFormatter.digitsOnly
                : WhitelistingTextInputFormatter(RegExp(r'[\s\S]+'))
          ],
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(),
            labelText: hint,
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
