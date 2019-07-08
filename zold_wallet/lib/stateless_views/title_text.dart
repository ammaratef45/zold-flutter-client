import 'package:flutter/material.dart';

/// Widget for title text
class TitleText extends StatelessWidget {
  /// ctor.
  const TitleText(this.data);

  /// Texst to be displayed.
  final String data;

  @override
  Widget build(BuildContext context) => Text(
        data,
        style: TextStyle(color: const Color(0xff1970b6), fontSize: 28),
      );
}
