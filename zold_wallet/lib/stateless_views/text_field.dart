import 'package:flutter/material.dart';

class ZoldTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hint;
  final String label;
  final double width;
  ZoldTextField(
    {
      @required this.controller,
      this.keyboardType = TextInputType.text,
      this.hint = '',
      this.label='',
      this.width = 240.0,

    }
  );

  @override
  Widget build(BuildContext context) =>
     Container(
      padding: EdgeInsets.all(2.0),
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder()
            , labelText: label
        ),
      ),
    );
  }


